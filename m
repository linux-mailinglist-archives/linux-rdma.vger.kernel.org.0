Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFDA7AC614
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Sep 2023 03:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjIXBSi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Sep 2023 21:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXBSh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Sep 2023 21:18:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A92B113;
        Sat, 23 Sep 2023 18:18:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40535597f01so42318075e9.3;
        Sat, 23 Sep 2023 18:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695518308; x=1696123108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o1Vtnil+maWEYz4kYiJjl4J4Ef/lHddA5G0vURgGn8=;
        b=BNZcC8phqTQEvJJHNynRfZ3LaOFFFMo1i1j8ZEjMNZXtALjWeVtJ9yf1UBUxlHkoJ3
         hlMru3QgNMpVWDLoQziqe+RyZvESkqxNCSRG/O2danOm0ABlKA14yZ/39nnDyA/jdaPx
         jJjO+hIGD14qgelKmEV9oYnjJxpPR3HPutwIkZtxEjEqK8eQUHkAdFAaa4m+PbR4JjNk
         6tfQ7hKzf1dnXwdY3wsW2t/wKKfo5Zpq/YKSWOLa/Xmsbnoc1+t3+tfNqj2cY5H8eAXF
         7YSHWPzk1yTR53yoYdDSE3Kv9LlkHUUTgzgFFt/hab8IDe/meqmI8tTYsGnv11BMGbg1
         jG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695518308; x=1696123108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o1Vtnil+maWEYz4kYiJjl4J4Ef/lHddA5G0vURgGn8=;
        b=PAJ62ELOTQ8CZFsXH6d9VT9koSxbvImyC68hAf+5kMgjxoBe423ThTVFgXJ1xPWm54
         s1jaiVqWmCL7uqJtt/lyYjWuwNsJ4txuuCd6iQoDcISndUxcjxoj4S2RGNFrE/DDxjm/
         6oBqa6pTIWcQhxxIWtMKcXdzGdtj/vhPxlNTQe3glJ7CkgF63h6TzVvaYW3PE4ClAvAv
         eVteJpky9StRxqZ0Z9t4KCSg21oF9cXaiB47BdGLLHZAckGVqWleDmzxeuDOkBL2l1VU
         jtyK6rtVZ26e0sOsk1osOf1SiJjixKqW33pBi2Jg+5relRgPm5AxvDo22lHsGTdtHYql
         FuKA==
X-Gm-Message-State: AOJu0YwUeXVDkLEatjaaJKrsdpwklsfOcZnlbzpCT/yqPGcWNjcuCT+h
        +80RUmWkZupNODLFv1u4kgF8M/pmrzCjzO5LRUvd+aBS
X-Google-Smtp-Source: AGHT+IEef9xMaC6O8p+qM7ieRJC8d292f787Een2he3dwN6BRXiWAdfcSUuMSYVzaghO1q5pHZU/FO5EUK22rf/tnrY=
X-Received: by 2002:adf:fa88:0:b0:31f:fe07:fde7 with SMTP id
 h8-20020adffa88000000b0031ffe07fde7mr3039981wrr.1.1695518308390; Sat, 23 Sep
 2023 18:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org> <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev> <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev> <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev> <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org> <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org> <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com> <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
In-Reply-To: <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
From:   Rain River <rain.1986.08.12@gmail.com>
Date:   Sun, 24 Sep 2023 09:17:46 +0800
Message-ID: <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
Subject: Re: [bug report] blktests srp/002 hang
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 23, 2023 at 2:14=E2=80=AFAM Bob Pearson <rpearsonhpe@gmail.com>=
 wrote:
>
> On 9/21/23 10:10, Zhu Yanjun wrote:
> >
> > =E5=9C=A8 2023/9/21 22:39, Bob Pearson =E5=86=99=E9=81=93:
> >> On 9/21/23 09:23, Rain River wrote:
> >>> On Thu, Sep 21, 2023 at 2:53=E2=80=AFAM Bob Pearson <rpearsonhpe@gmai=
l.com> wrote:
> >>>> On 9/20/23 12:22, Bart Van Assche wrote:
> >>>>> On 9/20/23 10:18, Bob Pearson wrote:
> >>>>>> But I have also seen the same behavior in the siw driver which is
> >>>>>> completely independent.
> >>>>> Hmm ... I haven't seen any hangs yet with the siw driver.
> >>>> I was on Ubuntu 6-9 months ago. Currently I don't see hangs on eithe=
r.
> >>>>>> As mentioned above at the moment Ubuntu is failing rarely. But it =
used to fail reliably (srp/002 about 75% of the time and srp/011 about 99% =
of the time.) There haven't been any changes to rxe to explain this.
> >>>>> I think that Zhu mentioned commit 9b4b7c1f9f54 ("RDMA/rxe: Add work=
queue
> >>>>> support for rxe tasks")?
> >>>> That change happened well before the failures went away. I was seein=
g failures at the same rate with tasklets
> >>>> and wqs. But after updating Ubuntu and the kernel at some point they=
 all went away.
> >>> I made tests on the latest Ubuntu with the latest kernel without the
> >>> commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")=
.
> >>> The latest kernel is v6.6-rc2, the commit 9b4b7c1f9f54 ("RDMA/rxe: Ad=
d
> >>> workqueue support for rxe tasks") is reverted.
> >>> I made blktest tests for about 30 times, this problem does not occur.
> >>>
> >>> So I confirm that without this commit, this hang problem does not
> >>> occur on Ubuntu without the commit 9b4b7c1f9f54 ("RDMA/rxe: Add
> >>> workqueue support for rxe tasks").
> >>>
> >>> Nanthan
> >>>
> >>>>> Thanks,
> >>>>>
> >>>>> Bart.
> >>>>
> >> This commit is very important for several reasons. It is needed for th=
e ODP implementation
> >> that is in the works from Daisuke Matsuda and also for QP scaling of p=
erformance. The work
> >> queue implementation scales well with increasing qp number while the t=
asklet implementation
> >> does not. This is critical for the drivers use in large scale storage =
applications. So, if
> >> there is a bug in the work queue implementation it needs to be fixed n=
ot reverted.
> >>
> >> I am still hoping that someone will diagnose what is causing the ULPs =
to hang in terms of
> >> something missing causing it to wait.
> >
> > Hi, Bob
> >
> >
> > You submitted this commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue suppor=
t for rxe tasks").
> >
> > You should be very familiar with this commit.
> >
> > And this commit causes regression.
> >
> > So you should delved into the source code to find the root cause, then =
fix it.
>
> Zhu,
>
> I have spent tons of time over the months trying to figure out what is ha=
ppening with blktests.
> As I have mentioned several times I have seen the same exact failure in s=
iw in the past although
> currently that doesn't seem to happen so I had been suspecting that the p=
roblem may be in the ULP.
> The challenge is that the blktests represents a huge stack of software mu=
ch of which I am not
> familiar with. The bug is a hang in layers above the rxe driver and so fa=
r no one has been able to
> say with any specificity the rxe driver failed to do something needed to =
make progress or violated
> expected behavior. Without any clue as to where to look it has been hard =
to make progress.

Bob

Work queue will sleep. If work queue sleep for long time, the packets
will not be sent to ULP. This is why this hang occurs.
Difficult to handle this sleep in work queue. It had better revert
this commit in RXE.
Because work queue sleeps,  ULP can not wait for long time for the
packets. If packets can not reach ULPs for long time, many problems
will occur to ULPs.

>
> My main motivation is making Lustre run on rxe and it does and it's fast =
enough to meet our needs.
> Lustre is similar to srp as a ULP and in all of our testing we have never=
 seen a similar hang. Other
> hangs to be sure but not this one. I believe that this bug will never get=
 resolved until someone with
> a good understanding of the ulp drivers makes an effort to find out where=
 and why the hang is occurring.
> From there it should be straight forward to fix the problem. I am continu=
ing to investigate and am learning
> the device-manager/multipath/srp/scsi stack but I have a long ways to go.
>
> Bob
>
>
> >
> >
> > Jason && Leon, please comment on this.
> >
> >
> > Best Regards,
> >
> > Zhu Yanjun
> >
> >>
> >> Bob
>
