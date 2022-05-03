Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5B35187D7
	for <lists+linux-rdma@lfdr.de>; Tue,  3 May 2022 17:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbiECPJ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 May 2022 11:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbiECPI6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 May 2022 11:08:58 -0400
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn [163.53.93.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5299B1BE91
        for <linux-rdma@vger.kernel.org>; Tue,  3 May 2022 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1651590290;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=1I2vCl99K7UHZR76Pu4L8pkgWEwmT4DYt+HWAPdRqiA=;
        b=VpRHjA2rJzir1XKLNQcuXuecVslOihK7Lfeb3nzaFgU/4maxP1hexM2wWC0Bg3OC
        RcTLj3BxOEBKHuyKMnGghPFmOyDdgpRboOvvxp1Gu1X0pBlWYqdIJVhb80bWaOGxKtk
        BG/PivlGLFO318vI+EC4+KnC801uPrYi/BfhTD6Q=
Received: from [192.168.255.10] (113.116.48.87 [113.116.48.87]) by mx.zoho.com.cn
        with SMTPS id 1651590288275792.5983625768279; Tue, 3 May 2022 23:04:48 +0800 (CST)
Date:   Tue, 3 May 2022 23:04:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] RDMA/rxe: skip adjusting remote addr for write in
 retry operation
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220502053907.6388-1-cgxu519@mykernel.net>
 <MW4PR84MB230773A6CD5414E6CC8E502CBCC19@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
From:   Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <6b41c49d-b3ed-8396-a217-c756a37b5e05@mykernel.net>
In-Reply-To: <MW4PR84MB230773A6CD5414E6CC8E502CBCC19@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

=E5=9C=A8 2022/5/3 1:15, Pearson, Robert B =E5=86=99=E9=81=93:
>> -----Original Message-----
>> From: Chengguang Xu <cgxu519@mykernel.net>
>> Sent: Monday, May 2, 2022 12:39 AM
>> To: zyjzyj2000@gmail.com; jgg@ziepe.ca; leon@kernel.org
>> Cc: linux-rdma@vger.kernel.org; Chengguang Xu <cgxu519@mykernel.net>
>> Subject: [RFC PATCH] RDMA/rxe: skip adjusting remote addr for write in r=
etry operation
>>
>> For write request the remote addr will be sent only with first packet so=
 we don't have to adjust wqe->iova in retry operation.
> This is problematic for lossy networks. A very large read request, say 8M=
iB, sends 2048 packets in response without any acknowledgement
> from the requester. If the packet loss rate was 1% the read request would=
 never finish as the probability of sending 2048 packets without
> loss is very small. The way the code works today is that the iova is adju=
sted, and if you are lucky the responder has already finished the
> previous read operation and starts over with a new read reply starting wi=
th a first packet at iova. If you are less fortunate the previous
> read reply has not finished and the responder will continue to work on it=
 until it is finished before looking at the new read request wqe.
> the completer will respond to each out of order packet by checking to see=
 if it should start a retry but since it has already done so
> it drops the packet. It's messy but one can make forward progress ~100 pa=
ckets at a time. It would be faster if the responder saw that
> the new request replaced the old one and stopped sending packets on the o=
ld read. I have no idea how CX NICs do this but just restarting
> from scratch seems bad.

I agree that read request indeed needs to adjust iova during retry and=C2=
=A0=20
the adjustment(for read) has already done in below logic in req_retry().


if (mask & WR_READ_MASK) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 npsn =3D (wqe->dma.length - wqe=
->dma.resid) /
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp->mtu;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wqe->iova +=3D npsn * qp->mtu;
}

For write request, retry will not send new iova because only first write=20
packet has RXE_RETH_MASK regardless iova adjustment.
Am I missing something?


Thanks,
Chengguang





