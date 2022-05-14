Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750E75271E6
	for <lists+linux-rdma@lfdr.de>; Sat, 14 May 2022 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiENOVW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 May 2022 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiENOVI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 14 May 2022 10:21:08 -0400
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn [163.53.93.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF38F72
        for <linux-rdma@vger.kernel.org>; Sat, 14 May 2022 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1652538062;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Message-ID:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=yJJ9zdW0XMMl72uPz2ouTv3OGeJR4TX/jmo1x2aYSac=;
        b=HaEbRrPXb319k76beF/lfocBYYAW2pTXWXOtv8kPqAjweUyIyo1x5kmt/AXLNGqn
        8mCbvyuISoMTgELKc/kNOpgXNN2ZeHLi//qfThYhBjOOca4V00dgUh2hhTX8wVrPkc1
        ECAYmCv6JyJVl1VvLAqZ67gRlHHC3XBzJmgADkJs=
Received: from [192.168.255.10] (116.30.195.187 [116.30.195.187]) by mx.zoho.com.cn
        with SMTPS id 1652538060839473.4094830715509; Sat, 14 May 2022 22:21:00 +0800 (CST)
Date:   Sat, 14 May 2022 22:20:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Question about AETH_NAK_PSN_SEQ_ERROR
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Message-ID: <7f51a1c8-757f-21c2-cf8d-fd91b5e26563@mykernel.net>
References: <2eeb36ab-0f4d-fc9a-44a6-9b6bfa2f7970@mykernel.net>
In-Reply-To: <2eeb36ab-0f4d-fc9a-44a6-9b6bfa2f7970@mykernel.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


=E5=9C=A8 2022/5/14 21:35, Chengguang Xu =E5=86=99=E9=81=93:
> Hello Folks,
>
>
> There is a logic(below code) in check_ack() in rxe_comp.c,=C2=A0 the case=
=20
> (AETH_NAK_PSN_SEQ_ERROR)
> indicates sending side received a nak ack which means opposite side=20
> had an psn seq error(expected psn < received psn).
> I don't fully understand the comment(/* a nak implicitly acks all=20
> packets with psns before */) here,
> could someone give me a hint for this?

Carefully checking rxe_resp.c and found the psn in the ack (with=20
AETH_NAK_PSN_SEQ_ERROR) is resp.psn not received pkt->psn.=C2=A0 :-)



>
> Also, set qp->comp.psn as pkt->psn will skip some psns(from=20
> qp->comp.psn to pkt->psn) in the retry, is it correct?
>
> Many thanks in advance!
> Chengguang
>
> -------------------------
>
> =C2=A0 case AETH_NAK:
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0switch (syn) {
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0case AETH_NAK_PS=
N_SEQ_ERROR:
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0/* a nak implicitly acks all packets with psns
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0 * before
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0 */
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0if (psn_compare(pkt->psn, qp->comp.psn) > 0) {
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0rxe_counter_inc(rxe,
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0RXE_CNT_RCV_SEQ=
_ERR);
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0qp->comp.psn =3D pkt->psn;
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0if (qp->req.wait_psn) {
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0qp->req.wait_psn =3D 0;
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0rxe_run_task(&qp->req.task, 0);
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0}
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0}
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0return COMPST_ERROR_RETRY;
>
>
>


