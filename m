Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F3B9F260
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 20:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbfH0SdZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 14:33:25 -0400
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:41458 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730424AbfH0SdZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Aug 2019 14:33:25 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id A828E1805A801;
        Tue, 27 Aug 2019 18:33:23 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CEC63182CF666;
        Tue, 27 Aug 2019 18:33:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:981:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7576:10004:10400:10848:11026:11232:11658:11914:12043:12297:12555:12679:12740:12760:12895:13069:13311:13357:13439:13548:14181:14659:14721:21080:21221:21451:21627:30054:30060:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: toad20_7493a051a5231
X-Filterd-Recvd-Size: 3368
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 27 Aug 2019 18:33:20 +0000 (UTC)
Message-ID: <b0fe444622e32af6c34f3326e5dce3513adf5113.camel@perches.com>
Subject: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Aug 2019 11:33:19 -0700
In-Reply-To: <CAMuHMdW0jEpE3YrA5Znq8O9e4eswARwYYerEhRLSLWxeXMbsEQ@mail.gmail.com>
References: <20190819100526.13788-1-geert@linux-m68k.org>
         <581e7d79ed75484beb227672b2695ff14e1f1e34.camel@perches.com>
         <CAMuHMdVh8dwd=77mHTqG80_D8DK+EtVGewRUJuaJzK1qRYrB+w@mail.gmail.com>
         <dbc03b4ac1ef4ba2a807409676cf8066@AcuMS.aculab.com>
         <CAMuHMdWHGTMwK+PO_BgsNZMpqRat1SHE-_CP0UqxEALA_OJeNg@mail.gmail.com>
         <20190827174639.GT1131@ZenIV.linux.org.uk>
         <CAMuHMdW0jEpE3YrA5Znq8O9e4eswARwYYerEhRLSLWxeXMbsEQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 2019-08-27 at 19:59 +0200, Geert Uytterhoeven wrote:
> On Tue, Aug 27, 2019 at 7:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Aug 27, 2019 at 07:29:52PM +0200, Geert Uytterhoeven wrote:
> > > On Tue, Aug 27, 2019 at 4:17 PM David Laight <David.Laight@aculab.com> wrote:
> > > > From: Geert Uytterhoeven
> > > > > Sent: 19 August 2019 18:15
> > > > ...
> > > > > > I think a cast to unsigned long is rather more common.
> > > > > > 
> > > > > > uintptr_t is used ~1300 times in the kernel.
> > > > > > I believe a cast to unsigned long is much more common.

btw: apparently that's not true.

This grep may be incomplete but it seems there are fewer
kernel uses of a cast to unsigned long then pointer:

$ git grep -P '\(\s*\w+(\s+\w+){0,3}(\s*\*)+\s*\)\s*\(\s*unsigned\s+long\s*\)'|wc -l
423

Maybe add a cast_to_ptr macro like

#define cast_to_ptr(type, val)	((type)(uintptr_t)(val))

though that may not save any horizontal space

and/or a checkpatch test like:
---
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 287fe73688f0..4ec88bc53f2f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6281,6 +6281,15 @@ sub process {
 			}
 		}
 
+# check for casts to pointer with intermediate casts to (unsigned long) not (uintptr_t)
+		if ($line =~ /\(\s*\w+(?:\s+\w+){0,3}(?:\s*\*){1,4}\s*\)\s*\(\s*unsigned\s+long\s*\)/) {
+			if (WARN("PREFER_UINTPTR_T",
+				 "prefer intermediate cast to uintptr_t\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/(\(\s*\w+(?:\s+\w+){0,3}(?:\s*\*){1,4}\s*\))\s*\(\s*unsigned\s+long\s*\)/$1(uintptr_t)/;
+			}
+		}
+
 # check for pointless casting of alloc functions
 		if ($line =~ /\*\s*\)\s*$allocFunctions\b/) {
 			WARN("UNNECESSARY_CASTS",

