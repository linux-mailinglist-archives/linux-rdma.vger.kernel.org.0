Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D63F083253
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfHFNKF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 6 Aug 2019 09:10:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfHFNKE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 09:10:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x76D3pY0142257
        for <linux-rdma@vger.kernel.org>; Tue, 6 Aug 2019 09:10:03 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.81])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u79kf9sem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 09:10:03 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 6 Aug 2019 13:09:59 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.88) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 6 Aug 2019 13:09:54 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2019080613095359-501946 ;
          Tue, 6 Aug 2019 13:09:53 +0000 
In-Reply-To: <044973ce7080eb5274befb99aab457897d577c96.camel@redhat.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Doug Ledford" <dledford@redhat.com>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Date:   Tue, 6 Aug 2019 13:09:53 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <044973ce7080eb5274befb99aab457897d577c96.camel@redhat.com>,<20190805141708.9004-1-bmt@zurich.ibm.com>
 <20190805141708.9004-2-bmt@zurich.ibm.com> <20190806121006.GC11627@ziepe.ca>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 3483
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19080613-3067-0000-0000-0000004565FF
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.195071
X-IBM-SpamModules-Versions: BY=3.00011559; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01242905; UDB=6.00655621; IPR=6.01024369;
 MB=3.00028065; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-06 13:09:57
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-06 07:47:03 - 6.00010253
x-cbparentid: 19080613-3068-0000-0000-0000006A6E87
Message-Id: <OF463E8E86.821A1088-ON0025844E.00485105-0025844E.0048510D@notes.na.collabserv.com>
Subject: RE: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit size to
 remove 64 bit architecture dependency of siw.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Doug Ledford" <dledford@redhat.com> wrote: -----

>To: "Jason Gunthorpe" <jgg@ziepe.ca>, "Bernard Metzler"
><bmt@zurich.ibm.com>
>From: "Doug Ledford" <dledford@redhat.com>
>Date: 08/06/2019 02:33PM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH 1/1] Make user mmapped CQ arming flags
>field 32 bit size to remove 64 bit architecture dependency of siw.
>
>On Tue, 2019-08-06 at 09:10 -0300, Jason Gunthorpe wrote:
>> On Mon, Aug 05, 2019 at 04:17:08PM +0200, Bernard Metzler wrote:
>> > Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> > ---
>> 
>> Don't send patches with empty commit messages. Every patch must
>have a
>> comprehensive commit message from now on.
>> 
>> >  drivers/infiniband/sw/siw/Kconfig     |  2 +-
>> >  drivers/infiniband/sw/siw/siw.h       |  2 +-
>> >  drivers/infiniband/sw/siw/siw_qp.c    | 14 ++++++++++----
>
>He had a decent commit log message, it was just in the cover letter. 
>Bernard, on single patch submissions, skip the cover letter and just
>send the patch by itself.  Then the nice explanation you gave in the
>cover letter should go in the commit message itself.
>
sorry about this. Frankly I am still newbie here and obviously and
unfortunately behave like this... A lame excuse, but I'll try hard
to improve.

Bernard.

