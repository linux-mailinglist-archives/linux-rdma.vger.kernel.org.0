Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB6150EF0C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Apr 2022 05:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiDZDN2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 23:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiDZDN1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 23:13:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346665F91
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 20:10:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q14so20207526ljc.12
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 20:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RZf97l/wm+IEcmMfZPiAtToahHb3DGj6gAN9wcpLEX0=;
        b=KlZq2it9IToH9/EW+XqHiZN6eGV75jW8r3Zj2yP4u7xu79yg2i/+G35NnzSlKThhoy
         /ctOjC71Pzy8VOJdu2ukm5882uP+sPyuSpHFfZGkTPzH9JJhnz+0d5UScTabQYOTNcT9
         31itBdRDmldMXLYdjZG6ryXmUabOIdR9MDfalVLxNIaIdAyXAghohGMFRa4FQ0Z/pAR7
         bvsxAYs7QcBPT/BcnNCJ7Nlu+bvoHZfiNgQYmX00ZIDB0Cna0Y0E/M5eFYA4K5ruydj5
         Yq5HDNG3D5+vM1R+p+2uiHLBUsGAgsD/h0mPsFa47Ed6gB6r/SBqm7mJx6SIeR25OkZH
         zJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RZf97l/wm+IEcmMfZPiAtToahHb3DGj6gAN9wcpLEX0=;
        b=hrMB5ZaP4Yjnz8xBWVqJvRcMl13LeMonmtMw7dG4AoU8AXRM27V2jimNV18/K6BNKw
         FTbms6VU+95pdhKENq459C+3c1H/Rqm7XhoIs21O10gw/hpMucSU3Z4oASubFDYoYzwN
         fIa2/4TCdJpizS99cuuLs7iCXW/06SAbcc/D6FUiirBr7F6o2yp0Ef3UNvY6VkBj9N1G
         QPBq7tK7boPjedv8un/vQvSkYtmg6LRheLhwHb68ajPLqNROJgMlAbXvFdcZcdbGo0v7
         gAXsatZNy57n3H8DUFZUHGhb5Q6sil4PoFzpcfrSmNr0QZzpeIGm5cVkX13CaXm9C8Ke
         RK5w==
X-Gm-Message-State: AOAM531C1gyoaBLpJ1cPw8f/mly8xutVHf+z0Tv26mn6Vwys3PABO/te
        S4tKQAHy3RirmNVeIbtgYMbqycDC8lp9Eh1PWak=
X-Google-Smtp-Source: ABdhPJxUctgR8mrugv3j7TFo/kRDyG0JRILvhz1KCHVvBIwTzP0x82LtsNyJXrGQ5RORToBZfH6f6GPkpXEf3ZlIHGE=
X-Received: by 2002:a2e:88ce:0:b0:24f:fff:603c with SMTP id
 a14-20020a2e88ce000000b0024f0fff603cmr5697435ljk.527.1650942618207; Mon, 25
 Apr 2022 20:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <5de7d1a9-a7ac-aea5-d11c-49423d3f0bf1@gmail.com>
 <98ad3df7-b934-ad2b-49c6-bb07a06a5c4f@linux.dev> <dfba7eb7-8467-59b5-2c2a-071ed1e4949f@gmail.com>
In-Reply-To: <dfba7eb7-8467-59b5-2c2a-071ed1e4949f@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 26 Apr 2022 11:10:06 +0800
Message-ID: <CAD=hENcsA5DqQMMnHEB-r07_4-PxJyVWNA6hCJjj2x0usfwrPg@mail.gmail.com>
Subject: Re: bug report for rdma_rxe
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 26, 2022 at 12:58 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 4/24/22 19:04, Yanjun Zhu wrote:
> > =E5=9C=A8 2022/4/23 5:04, Bob Pearson =E5=86=99=E9=81=93:
> >> Local operations in the rdma_rxe driver are not obviously idempotent. =
But, the
> >> RC retry mechanism backs up the send queue to the point of the wqe tha=
t is
> >> currently being acknowledged and re-walks the sq. Each send or write o=
peration is
> >> retried with the exception that the first one is truncated by the pack=
ets already
> >> having been acknowledged. Each read and atomic operation is resent exc=
ept that
> >> read data already received in the first wqe is not requested. But all =
the
> >> local operations are replayed. The problem is local invalidate which i=
s destructive.
> >> For example
> >
> > Is there any example or just your analysis?
>
> I have a colleague at HPE who is testing Lustre/o2iblnd/rxe. They are tes=
ting over a
> highly reliable network so do not expect to see dropped or out of order p=
ackets. But they
> see multiple timeout flows. When working on rping a week ago I also saw l=
ots of timeouts
> and verified that the timeout code in rxe has the behavior that when a ne=
w RC operation is
> sent the retry timer is modified to go off at jiffies + qp->timeout_jiffi=
es but only if
> there is not a currently pending timer. Once set it is never cleared so i=
t will fire
> typically a few msec later initiating a retry flow. If IO operations are =
frequent then
> there will be a timeout every few msec (about 20 times a second for typic=
al timeout values.)
> o2iblnd uses fast reg MRs to write data to the target system and then loc=
al invalidate
> operations to invalidate the MR and then increments the key portion of th=
e rkey and resets
> the map and then does a reg mr operation. Retry flows cause the local inv=
alidate and reg MR
> operations to be re-executed over and over again. A single retry can caus=
e a half a dozen
> invalidate operations to be run with various rkeys and they mostly fail b=
ecause they don't
> match the current MR. This results in Lustre crashing.
>
> Currently I am actually happy that the unneeded retries are happening bec=
ause it makes
> testing the retry code a lot easier. But eventually it would be good to c=
lear or reset the timer
> after the operation is completed which would greatly reduce the number of=
 retries. Also

This retry is triggered by RDMA/RXE or by some applications? And the
mr is used the original one or allocate a new one?

If this retry is triggered by RDMA/RXE, and the original mr is freed
and a new one is allocated, it is very similar to ODP.
Currently ODP is not supported in RXE, but the behavior is very similar.

Zhu Yanjun

> it will be important to figure out how the IBA intended for local invalid=
ates and reg MRs to
> work. The way they are now they cannot be successfully retried. Also mark=
ing them as done
> and skipping them in the retry sequence does not work. (It breaks some of=
 the blktests test
> cases.)
>
> > You know, sometimes your analysis is not always correct.
> > To prove your analysis, please show us some solid example.
> >
> > Zhu Yanjun
> >
> >>
> >> sq:    some operation that times out
> >>     bind mw to mr
> >>     some other operation
> >>     invalidate mw
> >>     invalidate mr
> >>
> >> can't be replayed because invalidating the mr makes the second bind fa=
il.
> >> There are lots of other examples where things go wrong.
> >>
> >> To make things worse the send queue timer is never cleared and for typ=
ical
> >> timeout values goes off every few msec whether anything actually faile=
d.
> >>
> >> Bob
> >
>
