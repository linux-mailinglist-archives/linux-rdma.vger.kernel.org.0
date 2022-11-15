Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB56295F1
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 11:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiKOKeF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 05:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbiKOKeA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 05:34:00 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA746319
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 02:33:58 -0800 (PST)
Subject: Re: [PATCH RFC 08/12] RDMA/rtrs: Kill recon_cnt from several structs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668508437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gn9PlR8hoktvfxq6YUppTmkkn7IgKYIluu4Vad7TIrU=;
        b=GkwZ4pn6DsDAQOL94qCwBlpftxkBmhkmBMLEGamp97Gcn7pRQjBcwlBNfMP5T8IeNWtX9C
        x1T48gQdk8mnteJexzQ2Tt9Xm1EwdwP994ED+6MmxcM49/VmAWykGJpopCUrm9T8hQLYge
        dWp4UT+bjjl4wQI/gMbVKJ3kcLluU08=
To:     Jinpu Wang <jinpu.wang@ionos.com>,
        Haris Iqbal <haris.iqbal@ionos.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-9-guoqing.jiang@linux.dev>
 <CAJpMwygWQgq+NicnOwJRU-zn32t55KtKQO5q6-68YqtCvd19iQ@mail.gmail.com>
 <CAMGffEn64htbjrgCorEXXiZM8TLjEUo0ixzz+BU7nN5QAprLBA@mail.gmail.com>
 <CAMGffEmEGVJFGY6NEg+NvPG_h5A4J7oKtDhEw13=Kdn+13Fdrg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <52fec35a-e7d1-09d7-728f-60c2f86bd498@linux.dev>
Date:   Tue, 15 Nov 2022 18:33:50 +0800
MIME-Version: 1.0
In-Reply-To: <CAMGffEmEGVJFGY6NEg+NvPG_h5A4J7oKtDhEw13=Kdn+13Fdrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/15/22 5:58 PM, Jinpu Wang wrote:
> On Tue, Nov 15, 2022 at 10:53 AM Jinpu Wang <jinpu.wang@ionos.com> wrote:
>> On Tue, Nov 15, 2022 at 10:39 AM Haris Iqbal <haris.iqbal@ionos.com> wrote:
>>> On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>>>> Seems the only relevant comment about recon_cnt is,
>>>>
>>>> /*
>>>>   * On every new session connections increase reconnect counter
>>>>   * to avoid clashes with previous sessions not yet closed
>>>>   * sessions on a server side.
>>>>   */
>>>>
>>>> However, it is not clear how the recon_cnt avoid clashed at these places
>>>> in the commit since no where checks it.
>>> It does seem redundant. This predates my time, so I don't know if
>>> there was a change which removed the usage of this. I tried to search
>>> in commit history, but couldn't.
>>>
>>> @Jinpu Your thoughts?
> Sorry for sending an empty reply.
> I checked a bit, and also can find a reason why the recon_cnt was
> added, it is not checked on the server side.
> I think it's ok to remove it. But we can simply remove the field in
> rtrs_msg_conn_req, commented below.
>
>>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>>>> ---
>>>>   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 8 --------
>>>>   drivers/infiniband/ulp/rtrs/rtrs-pri.h | 3 ---
>>>>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 7 +------
>>>>   3 files changed, 1 insertion(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>>>> index 5ffc170dae8c..dcc8c041a141 100644
>>>> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>>>> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>>>> @@ -1802,7 +1802,6 @@ static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
>>>>                  .version = cpu_to_le16(RTRS_PROTO_VER),
>>>>                  .cid = cpu_to_le16(con->c.cid),
>>>>                  .cid_num = cpu_to_le16(clt_path->s.con_num),
>>>> -               .recon_cnt = cpu_to_le16(clt_path->s.recon_cnt),
>>>>          };
>>>>          msg.first_conn = clt_path->for_new_clt ? FIRST_CONN : 0;
>>>>          uuid_copy(&msg.sess_uuid, &clt_path->s.uuid);
>>>> @@ -2336,13 +2335,6 @@ static int init_conns(struct rtrs_clt_path *clt_path)
>>>>          unsigned int cid;
>>>>          int err;
>>>>
>>>> -       /*
>>>> -        * On every new session connections increase reconnect counter
>>>> -        * to avoid clashes with previous sessions not yet closed
>>>> -        * sessions on a server side.
>>>> -        */
>>>> -       clt_path->s.recon_cnt++;
>>>> -
>>>>          /* Establish all RDMA connections  */
>>>>          for (cid = 0; cid < clt_path->s.con_num; cid++) {
>>>>                  err = create_con(clt_path, cid);
>>>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
>>>> index a2420eecaf5a..c4ddaeba1c59 100644
>>>> --- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
>>>> +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
>>>> @@ -109,7 +109,6 @@ struct rtrs_path {
>>>>          struct rtrs_con **con;
>>>>          unsigned int            con_num;
>>>>          unsigned int            irq_con_num;
>>>> -       unsigned int            recon_cnt;
>>>>          unsigned int            signal_interval;
>>>>          struct rtrs_ib_dev      *dev;
>>>>          int                     dev_ref;
>>>> @@ -177,7 +176,6 @@ struct rtrs_sg_desc {
>>>>    * @version:      RTRS protocol version
>>>>    * @cid:          Current connection id
>>>>    * @cid_num:      Number of connections per session
>>>> - * @recon_cnt:    Reconnections counter
>>>>    * @sess_uuid:    UUID of a session (path)
>>>>    * @paths_uuid:           UUID of a group of sessions (paths)
>>>>    *
>>>> @@ -196,7 +194,6 @@ struct rtrs_msg_conn_req {
>>>>          __le16          version;
>>>>          __le16          cid;
>>>>          __le16          cid_num;
>>>> -       __le16          recon_cnt;
>>>>          uuid_t          sess_uuid;
>>>>          uuid_t          paths_uuid;
>>>>          u8              first_conn : 1;
> We can remove it from protocol, this break compatibility with older kernel.

Can we bump up RTRS_PROTO_VER_MINOR for the compatibility? Otherwise
those structs are immutable forever.

Thanks,
Guoqing
