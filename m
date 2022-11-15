Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D366295B8
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 11:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiKOKYm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 05:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKOKYm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 05:24:42 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2F4A45C
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 02:24:41 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668507879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fAj/+eTDOEBLhjlKopc3Ikly2MGaN3429U2KBKTQpMU=;
        b=G/itTZ/zjznOfGRpfH0TJuMSkp0Di/u3Ic+FZoFlB5+mpSnlM7zNRN5XAF5ISAv5bArt/R
        mvFeJ6RGDKdy1VhoyAkkyJjBDedS0H1OzEaRmWd9B5t/iww0THcKS/GAJWapL3NdNmQ0UO
        AxuQ0QsGOQRbubgJBBGdpqThq1x5rfQ=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH RFC 03/12] RDMA/rtrs-srv: Only close srv_path if it is
 just allocated
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-4-guoqing.jiang@linux.dev>
 <CAJpMwyhFo2PFMqtz1_BBdNDWyaYYPOMFj7kE0p=16uUQsvmUew@mail.gmail.com>
Message-ID: <0cea8072-ea26-9031-6f74-8707125e7d15@linux.dev>
Date:   Tue, 15 Nov 2022 18:24:39 +0800
MIME-Version: 1.0
In-Reply-To: <CAJpMwyhFo2PFMqtz1_BBdNDWyaYYPOMFj7kE0p=16uUQsvmUew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/15/22 12:18 AM, Haris Iqbal wrote:
> On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang<guoqing.jiang@linux.dev>  wrote:
>> RTRS creates several connections per nr_cpu_ids, it makes more sense
>> to only close the path when it just allocated.
>>
>> Signed-off-by: Guoqing Jiang<guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
>> index 2cc8b423bcaa..063082d29fc6 100644
>> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
>> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
>> @@ -1833,6 +1833,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>>          u16 version, con_num, cid;
>>          u16 recon_cnt;
>>          int err = -ECONNRESET;
>> +       bool alloc_path = false;
>>
>>          if (len < sizeof(*msg)) {
>>                  pr_err("Invalid RTRS connection request\n");
>> @@ -1906,6 +1907,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>>                          pr_err("RTRS server session allocation failed: %d\n", err);
>>                          goto reject_w_err;
>>                  }
>> +               alloc_path = true;
>>          }
>>          err = create_con(srv_path, cm_id, cid);
>>          if (err) {
>> @@ -1940,7 +1942,8 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>>
>>   close_and_return_err:
>>          mutex_unlock(&srv->paths_mutex);
>> -       close_path(srv_path);
>> +       if (alloc_path)
>> +               close_path(srv_path);
> I think the way this is coded is, if there is a problem opening a
> connection in that srv_path, then it closes that srv_path gracefully,
> which results in all other connections in that path getting closed,
> and the IOs being failover'ed to the other path (in case of
> multipath), and then the client would trigger an auto reconnect.

Could it possible that IO is happening in the previous connection, then 
a later
failed connection try to close all the connections.

> @Jinpu can shed some more light, what would be the preferred course of
> action if there is a failure in one connection. To keep the current
> design or to avoid closing the path in case of a connection issue.

Frankly, I am less confident about this patch and seems it is a rare 
condition.
Will just drop it for now.

Thanks,
Guoqing
