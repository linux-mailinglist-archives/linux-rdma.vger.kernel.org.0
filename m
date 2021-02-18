Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477BA31EFC9
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 20:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhBRTYO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 14:24:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230400AbhBRSsm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Feb 2021 13:48:42 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11IIhtPU099674
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 13:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=wKtNQSUxlo7nQDCk6cnIKkwK4YL4wz1dK++EVebUXtI=;
 b=VJSGZy6Qi/RfquaNfkCJpOHQO/mAJLf/tl6T61pWQ+0Xz0jnToCnJnrIo4dIm+bEsRhj
 zLeigd8SGIJLEt2Eg1Sh4AWW69GaUBTgWKzeqkdKb/COQbmmsruYN7wT9m/OE3HlMEpD
 MTMkzUWg3sCYUZeGT1k5sY/QdljRsU8WMYUR4tuHJMS64Wle35eTuj0fv0MzhBYUqaeX
 /vH2Y+WfXSw0EOG7Kyez8cpPnM/9gspyMBOJ3Q6DWdxBnyUQupN6Zg4gt8+isQmJ64wb
 UzEVxE1MitHdFzqS20wdO5kQC+O0fPqfx834HHe3/6tHSdXNZPvAFAs1aTSIkqK9oH0h eg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36sws6g3df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 13:48:02 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 18 Feb 2021 18:48:02 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
        by smtp.notes.na.collabserv.com (10.122.47.52) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 18 Feb 2021 18:48:00 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp01.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021021818480004-642108 ;
          Thu, 18 Feb 2021 18:48:00 +0000 
In-Reply-To: <20210218162329.GZ4718@ziepe.ca>
Subject: Re: Re: ibv_req_notify_cq clarification
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Gal Pressman" <galpress@amazon.com>,
        "RDMA mailing list" <linux-rdma@vger.kernel.org>
Date:   Thu, 18 Feb 2021 18:47:59 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20210218162329.GZ4718@ziepe.ca>,<bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 668C69D2:6FFE9230-00258680:0066C11E;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 479
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21021818-3633-0000-0000-000003A753C3
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000061
X-IBM-SpamModules-Versions: BY=3.00014756; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01509696; UDB=6.00815233; IPR=6.01292219;
 MB=3.00036175; MTD=3.00000008; XFM=3.00000015; UTC=2021-02-18 18:48:01
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-02-18 16:29:43 - 6.00012311
x-cbparentid: 21021818-3634-0000-0000-00002C7B5A83
Message-Id: <OF668C69D2.6FFE9230-ON00258680.0066C11E-00258680.0067452D@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_09:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Gal Pressman" <galpress@amazon.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 02/18/2021 07:35PM
>Cc: "RDMA mailing list" <linux-rdma@vger.kernel.org>
>Subject: [EXTERNAL] Re: ibv=5Freq=5Fnotify=5Fcq clarification
>
>On Thu, Feb 18, 2021 at 05:52:16PM +0200, Gal Pressman wrote:
>> On 18/02/2021 14:53, Jason Gunthorpe wrote:
>> > On Thu, Feb 18, 2021 at 11:13:43AM +0200, Gal Pressman wrote:
>> >> I'm a bit confused about the meaning of the ibv=5Freq=5Fnotify=5Fcq()
>verb:
>> >> "Upon the addition of a new CQ entry (CQE) to cq, a completion
>event will be
>> >> added to the completion channel associated with the CQ."
>> >>
>> >> What is considered a new CQE in this case?
>> >> The next CQE from the user's perspective, i.e. any new CQE that
>wasn't consumed
>> >> by the user's poll cq?
>> >> Or any new CQE from the device's perspective?
>> >=20
>> > new CQE from the device perspective.
>> >=20
>> >> For example, if at the time of ibv=5Freq=5Fnotify=5Fcq() call the CQ
>has received 100
>> >> completions, but the user hasn't polled his CQ yet, when should
>he be notified?
>> >> On the 101 completion or immediately (since there are
>completions waiting on the
>> >> CQ)?
>> >=20
>> > 101 completion
>> >=20
>> > It is only meaningful to call it when the CQ is empty.
>>=20
>> Thanks, so there's an inherent race between the user's CQ poll and
>the next arm?
>
>I think the specs or man pages talk about this, the application has
>to
>observe empty, do arm, then poll again then sleep on the cq if empty.
>

I'd love to see the IB=5FCQ=5FREPORT=5FMISSED=5FEVENTS flag mechanics
available for user land verbs. I learned about this potential
race the hard way when a well known distributed FS sometimes
hung ;)=20



>> Do you know what's the purpose of the consumer index in the arm
>doorbell that's
>> implemented by many providers?
>
>The consumer index is needed by HW to prevent CQ overflow, presumably
>the drivers push to reduce the cases where the HW has to read it from
>PCI
>
>Jason
>

