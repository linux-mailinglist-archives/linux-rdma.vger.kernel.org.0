Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658B95298FE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 07:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiEQFND (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 01:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbiEQFNC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 01:13:02 -0400
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn [163.53.93.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5920275CB
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 22:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1652764372;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=cic6GCVa562snG1G4OtGMxmT7IOEVCv4aFCfD+8xY2A=;
        b=e6GEX0ic3IBf0SajuA8hiYO7+9lMw5CkU5ycxztmxbA4Wz7f364N9w2zQ9fTULu8
        e6IkHETyihIyhC13/huD/dzTZXMwr5jFTARLliGK3Pl83O62iFG4pslKhDkdtFbK9zn
        77dtiLiB1hMP3fR3HNqkXfNtfdAltjfn5NIfBPWM=
Received: from [192.168.255.10] (113.108.77.66 [113.108.77.66]) by mx.zoho.com.cn
        with SMTPS id 1652764369627136.7957860436769; Tue, 17 May 2022 13:12:49 +0800 (CST)
Date:   Tue, 17 May 2022 13:12:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Question about AETH_NAK_PSN_SEQ_ERROR
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <2eeb36ab-0f4d-fc9a-44a6-9b6bfa2f7970@mykernel.net>
 <7f51a1c8-757f-21c2-cf8d-fd91b5e26563@mykernel.net>
 <64bb14e5-2511-e78f-8618-d1877cc856bb@gmail.com>
From:   Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <1298f881-ff4c-7f29-2688-a104e64137b2@mykernel.net>
In-Reply-To: <64bb14e5-2511-e78f-8618-d1877cc856bb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


=E5=9C=A8 2022/5/15 0:22, Bob Pearson =E5=86=99=E9=81=93:
> On 5/14/22 09:20, Chengguang Xu wrote:
>> =E5=9C=A8 2022/5/14 21:35, Chengguang Xu =E5=86=99=E9=81=93:
>>> Hello Folks,
>>>
>>>
>>> There is a logic(below code) in check_ack() in rxe_comp.c,=C2=A0 the ca=
se (AETH_NAK_PSN_SEQ_ERROR)
>>> indicates sending side received a nak ack which means opposite side had=
 an psn seq error(expected psn < received psn).
>>> I don't fully understand the comment(/* a nak implicitly acks all packe=
ts with psns before */) here,
>>> could someone give me a hint for this?
> For a start go to
>
> https://www.infinibandta.org/ibta-specification/
>
> and follow the directions to get access to the InfiniBand Architecture Sp=
ecification Vol. 1. It should be
> free but you have to provide contact information. Unless your company is =
a member of the IBTA.
>
> If you already have access then look at IBA 9.7.5.1.2 Coalesced Acknowled=
ge Messages.
>
> Any response carrying a packet sequence number implicitly acks all reques=
t packets with
> a PSN smaller than the one carried in the response packet. It may ack or =
nak the request packet
> with the same psn.
>
>> Carefully checking rxe_resp.c and found the psn in the ack (with AETH_NA=
K_PSN_SEQ_ERROR) is resp.psn not received pkt->psn.=C2=A0 :-)
>>
> resp.psn will carry the correct response psn for the current response pac=
ket. This will be the same
> as the psn of the req packet for send/write, and atomic requests but will=
 be one of the range
> of psns of a read request response. I.e. if the mtu is 4K and the read is=
 1MB there will be
> 256 read response packets to reply to the read request with psns starting=
 at the psn of the
> request and increasing by 1 until the message is done. The next request p=
acket must leave a gap of
> 255 psns.

Thank you very much for detailed explanation!

Chengguang


