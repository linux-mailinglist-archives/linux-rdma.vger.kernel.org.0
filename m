Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01DA48642B
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 16:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbfHHOSE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 8 Aug 2019 10:18:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730993AbfHHOSE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Aug 2019 10:18:04 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78E7Qlm094451
        for <linux-rdma@vger.kernel.org>; Thu, 8 Aug 2019 10:18:03 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.119])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u8kmx5c1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 08 Aug 2019 10:18:02 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 8 Aug 2019 14:18:02 -0000
Received: from us1b3-smtp02.a3dr.sjc01.isc4sb.com (10.122.7.175)
        by smtp.notes.na.collabserv.com (10.122.182.123) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 8 Aug 2019 14:17:57 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp02.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019080814175679-510523 ;
          Thu, 8 Aug 2019 14:17:56 +0000 
In-Reply-To: <19b1f6ad96bc2dc4d2134c32a2e79c11986ea038.camel@redhat.com>
Subject: Re: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit size
 to remove 64 bit architecture dependency of siw.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Doug Ledford" <dledford@redhat.com>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Date:   Thu, 8 Aug 2019 14:17:57 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <19b1f6ad96bc2dc4d2134c32a2e79c11986ea038.camel@redhat.com>,<20190806173526.GJ11627@ziepe.ca>,<20190806163901.GI11627@ziepe.ca>
 <20190806153105.GG11627@ziepe.ca> <20190806121006.GC11627@ziepe.ca>
 <20190805141708.9004-1-bmt@zurich.ibm.com>
 <20190805141708.9004-2-bmt@zurich.ibm.com>
 <OFCF70B144.E0186C06-ON0025844E.0050E500-0025844E.0051D4FA@notes.na.collabserv.com>
 <OF8985846C.2F1A4852-ON0025844E.005AADBA-0025844E.005B3A41@notes.na.collabserv.com>
 <OF3F75D9B9.20A30B62-ON0025844E.005D311D-0025844E.005D8CF2@notes.na.collabserv.com>
 <OF3FCBE885.788F61B5-ON0025844F.002DF52F-0025844F.0061F0FB@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 960ACAF9:E44A6FA7-00258450:003C6AE7;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 24947
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19080814-3975-0000-0000-00000015521C
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.028409
X-IBM-SpamModules-Versions: BY=3.00011570; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01243870; UDB=6.00656205; IPR=6.01025348;
 MB=3.00028092; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-08 14:18:00
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-08 11:51:53 - 6.00010260
x-cbparentid: 19080814-3976-0000-0000-000000235B19
Message-Id: <OF960ACAF9.E44A6FA7-ON00258450.003C6AE7-00258450.004E8C35@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Doug Ledford" <dledford@redhat.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>, "Jason Gunthorpe"
><jgg@ziepe.ca>
>From: "Doug Ledford" <dledford@redhat.com>
>Date: 08/07/2019 08:53PM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: Re: [PATCH 1/1] Make user mmapped CQ arming
>flags field 32 bit size to remove 64 bit architecture dependency of
>siw.
>
>On Wed, 2019-08-07 at 17:49 +0000, Bernard Metzler wrote:
>> 
>> It hurts, but I did finally setup qemu with a ppc image to check,
>> and so you are right!
>> 
>> ...
>> 
>> #ifdef __BIG_ENDIAN__
>> 
>> seem to be available in both kernel and user land...
>> 
>> But, general question: siw in its current shape isn't out
>> for long, older versions from github are already broken with
>> the abi. So, silently changing the abi at this stage of siw
>> deployment is no option? It's a hassle to see an old mistake
>> carried along forever with that #ifdef statement...no?
>
>I was thinking about that myself.
>
>This really hasn't been out long enough to completely tie our hands
>here.  A point update to rdma-core will resolve any user side issues.
>

What we are aiming at is ensuring backward compatibility
for 64bit-BE architectures, which are using siw since this year.
The community is likely of size zero. 
I found it hard to find a machine, even in the ppc world, which
let me test that BE thing. I ended up with an emulator. So I
assume it is no real world issue to now just change the 64bits 
flag into 32bits and add a 32bit pad for ABI compliance.

At the other hand, the change would be marginal (but awkward!):

diff --git a/include/uapi/rdma/siw-abi.h b/include/uapi/rdma/siw-abi.h
index af735f55b291..162b861ad2ac 100644
--- a/include/uapi/rdma/siw-abi.h
+++ b/include/uapi/rdma/siw-abi.h
@@ -180,7 +180,12 @@ struct siw_cqe {
  * to control CQ arming.
  */
 struct siw_cq_ctrl {
+#ifdef __BIG_ENDIAN__
+       __u32 pad;
+       __u32 flags;
+#else
        __u32 flags;
        __u32 pad;
+#endif
 };
 #endif

I propose taking my initial patch (w/o conditional endianess code).
But I can live with the ugly. Let me know.

In any case, I will make a PR for the user lib, since we changed
the variable to 32 bits...

Thanks
Bernard.

>Are they doing stable kernel patches for the last kernel?  If so, we
>can
>fix it both places.  No distros have picked up the original ABI in
>this
>short of a window and managed to get it into a shipped product, so we
>can notify any that might have picked up the broken version and get
>that
>updated too if we don't dilly dally and make the call quickly.
>
>-- 
>Doug Ledford <dledford@redhat.com>
>    GPG KeyID: B826A3330E572FDD
>    Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
>
[attachment "signature.asc" removed by Bernard Metzler/Zurich/IBM]

