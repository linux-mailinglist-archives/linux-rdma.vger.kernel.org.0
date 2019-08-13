Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030278BB6B
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2019 16:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfHMOYx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 13 Aug 2019 10:24:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbfHMOYx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Aug 2019 10:24:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7DEOVQv073673
        for <linux-rdma@vger.kernel.org>; Tue, 13 Aug 2019 10:24:52 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ubw77n8n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 13 Aug 2019 10:24:41 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 13 Aug 2019 14:24:36 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 13 Aug 2019 14:24:29 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2019081314242924-547535 ;
          Tue, 13 Aug 2019 14:24:29 +0000 
In-Reply-To: <20190813103028.GH29138@mtr-leonro.mtl.com>
Subject: Re: Re: [PATCH v2] Make user mmapped CQ arming flags field 32-bit size to
 remove 64-bit architecture dependency of siw.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Doug Ledford" <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        jgg@ziepe.ca
Date:   Tue, 13 Aug 2019 14:24:29 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190813103028.GH29138@mtr-leonro.mtl.com>,<20190809151816.13018-1-bmt@zurich.ibm.com>
 <a4e4215dab3715e0181fa6c97b583f3feb3d582d.camel@redhat.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 20323
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19081314-8889-0000-0000-000000187A6D
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000208
X-IBM-SpamModules-Versions: BY=3.00011588; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01246245; UDB=6.00657644; IPR=6.01027751;
 MB=3.00028159; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-13 14:24:35
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-13 09:43:50 - 6.00010280
x-cbparentid: 19081314-8890-0000-0000-000000258E5D
Message-Id: <OFB0FC3AF7.C591F2A8-ON00258455.004F2555-00258455.004F255D@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Doug Ledford" <dledford@redhat.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 08/13/2019 12:30PM
>Cc: "Bernard Metzler" <bmt@zurich.ibm.com>,
>linux-rdma@vger.kernel.org, jgg@ziepe.ca
>Subject: [EXTERNAL] Re: [PATCH v2] Make user mmapped CQ arming flags
>field 32-bit size to remove 64-bit architecture dependency of siw.
>
>On Mon, Aug 12, 2019 at 11:17:00AM -0400, Doug Ledford wrote:
>> On Fri, 2019-08-09 at 17:18 +0200, Bernard Metzler wrote:
>> > This patch changes the driver/user shared (mmapped) CQ
>notification
>> > flags field from unsigned 64-bits size to unsigned 32-bits size.
>This
>> > enables building siw on 32-bit architectures.
>> >
>> > This patch changes the siw-abi. On previously supported 64-bits
>> > little-endian architectures, the old siw user library remains
>> > usable, since the used 2 lowest bits of the new 32-bits field
>reside
>> > at the same memory location as those of the old 64-bits field.
>> > On 64-bits big-endian systems, the changes would break
>compatibility.
>> > Given the very short time of availability of siw with the current
>ABI,
>> > we do not expect current usage of siw on 64-bit big-endian
>systems.
>> >
>> > An according patch to change the siw user library fitting the new
>ABI
>> > will be provided to rdma-core.
>>
>> I changed the commit message somewhat.  The siw driver was just
>taken
>> into the upstream kernel this merge window, so there is no need to
>be
>> apologetic about abi breakage, there are *no* released kernels with
>a
>> prior abi.  We are only guaranteeing abi compatibility for the
>official
>> siw as taken into the upstream kernel and into rdma-core, and those
>will
>> be kept in sync starting with their first official release, which
>has
>> not yet happened.  Until this rc cycle is complete, we can fix up
>> anything that needs fixed up, so if there are any other abi issues
>you
>> think you would like to address, well, chop! chop! ;-)
>>
>> With that said, thanks, applied to for-rc.
>>
>
>Please send relevant change to rdma-core too.
>

Thanks for the reminder, absolutely!

I created a PR#564.

Thanks very much,
Bernard.

