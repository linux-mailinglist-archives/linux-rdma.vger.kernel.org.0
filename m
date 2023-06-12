Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCB172B570
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 04:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjFLCdj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 22:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFLCdi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 22:33:38 -0400
Received: from out-36.mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDE6C5
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 19:33:34 -0700 (PDT)
Message-ID: <abd54996-e2c0-10f9-281c-0f419e145735@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686537211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMfEgbkT7Ki+Ed0ToWf2yhTFxs/AIoNwNPoqmtSxxU8=;
        b=spS7Eo6fxkabogr3UduKCSff+hX34vYS7ouot+BdQ9/bqeQtUMZi/ERzrA7jBseX9F53+d
        aFRAor0u3K3yNGuTMRyReh2rkkMMh8gXsmsRVaOb6TT1Di5In4+WNsiGkm0+dxQfHyVw0E
        edncKgNx1DJYBS/87o62ThzFUB2kt+I=
Date:   Mon, 12 Jun 2023 10:33:26 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tom Talpey <tom@talpey.com>, Chuck Lever <cel@kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
 <dd9f65ab-d54f-7830-8043-57ea66c76149@talpey.com>
 <ZIRm9s9xjq3ioKtQ@nvidia.com>
 <A622612B-935F-4439-B348-D03E306E6DF4@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <A622612B-935F-4439-B348-D03E306E6DF4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/6/12 8:19, Chuck Lever III 写道:
> 
> 
>> On Jun 10, 2023, at 8:05 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Fri, Jun 09, 2023 at 04:49:49PM -0400, Tom Talpey wrote:
>>> On 6/7/2023 3:43 PM, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> We would like to enable the use of siw on top of a VPN that is
>>>> constructed and managed via a tun device. That hasn't worked up
>>>> until now because ARPHRD_NONE devices (such as tun devices) have
>>>> no GID for the RDMA/core to look up.
>>>>
>>>> But it turns out that the egress device has already been picked for
>>>> us. addr_handler() just has to do the right thing with it.
>>>>
>>>> Tested with siw and qedr, both initiator and target.
>>>>
>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>   drivers/infiniband/core/cma.c |    3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> This of course needs broader testing, but it seems to work, and it's
>>>> a little nicer than "if (dev_type == ARPHRD_NONE)".
>>>>
>>>> One thing I discovered is that the NFS/RDMA server implementation
>>>> does not deal at all with more than one RDMA device on the system.
>>>> I will address that with an ib_client; SunRPC patches forthcoming.
>>>>
>>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>>>> index 56e568fcd32b..c9a2bdb49e3c 100644
>>>> --- a/drivers/infiniband/core/cma.c
>>>> +++ b/drivers/infiniband/core/cma.c
>>>> @@ -694,6 +694,9 @@ cma_validate_port(struct ib_device *device, u32 port,
>>>>    if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
>>>>    return ERR_PTR(-ENODEV);
>>>> + 	if (rdma_protocol_iwarp(device, port))
>>>> + 		return rdma_get_gid_attr(device, port, 0);
>>>
>>> This might work, but I'm skeptical of the conditional. There's nothing
>>> special about iWARP that says a GID should come from the outgoing device
>>> mac. And, other protocols without IB GID addressing won't benefit.
>>
>> The GID represents the source address, so it better come from the
>> outgoing device or something is really wrong.
>>
>> iWARP gets a conditional because iwarp always has a single GID, other
>> devices do not work that way.
> 
> If rdma_get_gid_attr() works for rxe, perhaps we could change
> the conditional to match on only software-emulated devices.


drivers/infiniband/sw/rxe/rxe_net.c:

453 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
454                                 int paylen, struct rxe_pkt_info *pkt)
455 {
456         unsigned int hdr_len;
457         struct sk_buff *skb = NULL;
458         struct net_device *ndev;
459         const struct ib_gid_attr *attr;
460         const int port_num = 1;
461
462         attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, 
av->grh.sgid_index);
463         if (IS_ERR(attr))
464                 return NULL;
465
...

Zhu Yanjun

> 
> 
> --
> Chuck Lever
> 
> 

