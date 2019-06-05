Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D2535E1D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 15:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfFENlT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 5 Jun 2019 09:41:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727917AbfFENlT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 09:41:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x55DVWbw067904
        for <linux-rdma@vger.kernel.org>; Wed, 5 Jun 2019 09:41:18 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sxegsry6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 09:41:17 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 5 Jun 2019 13:41:17 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 5 Jun 2019 13:41:13 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2019060513411216-451182 ;
          Wed, 5 Jun 2019 13:41:12 +0000 
In-Reply-To: <20190604181540.GE15385@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 5 Jun 2019 13:41:12 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190604181540.GE15385@ziepe.ca>,<20190603174948.GA13214@ziepe.ca>
 <20190526114156.6827-1-bmt@zurich.ibm.com>
 <OF2964C589.75C558D3-ON0025840F.004421F3-0025840F.0060CBAD@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 3327
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19060513-1799-0000-0000-00000BC45AB4
X-IBM-SpamModules-Scores: BY=0.075804; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.008293
X-IBM-SpamModules-Versions: BY=3.00011218; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01213600; UDB=6.00637869; IPR=6.00994673;
 BA=6.00006328; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027194; XFM=3.00000015;
 UTC=2019-06-05 13:41:15
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-05 12:10:11 - 6.00010011
x-cbparentid: 19060513-1800-0000-0000-0000FFAA65CB
Message-Id: <OFF1828D60.768472D6-ON00258410.004A926D-00258410.004B2F1C@notes.na.collabserv.com>
Subject: Re:  Re: [PATCH for-next v1 00/12] SIW: Software iWarp RDMA (siw) driver
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 06/04/2019 08:26PM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH for-next v1 00/12] SIW: Software iWarp
>RDMA (siw) driver
>
>On Tue, Jun 04, 2019 at 05:37:15PM +0000, Bernard Metzler wrote:
>> 
>> >To: "Bernard Metzler" <bmt@zurich.ibm.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 06/03/2019 07:50PM
>> >Cc: linux-rdma@vger.kernel.org
>> >Subject: [EXTERNAL] Re: [PATCH for-next v1 00/12] SIW: Software
>iWarp
>> >RDMA (siw) driver
>> >
>> >On Sun, May 26, 2019 at 01:41:44PM +0200, Bernard Metzler wrote:
>> >> This patch set contributes the SoftiWarp driver rebased for
>> >> Kernel 5.2-rc1. SoftiWarp (siw) implements the iWarp RDMA
>> >> protocol over kernel TCP sockets. The driver integrates with
>> >> the linux-rdma framework.
>> >> 
>> >> With this new driver version, the following things where
>> >> changed, compared to the v8 RFC of siw:
>> >> 
>> >> o Rebased to 5.2-rc1
>> >> 
>> >> o All IDR code got removed.
>> >> 
>> >> o Both MR and QP deallocation verbs now synchronously
>> >>   free the resources referenced by the RDMA mid-layer.
>> >> 
>> >> o IPv6 support was added.
>> >> 
>> >> o For compatibility with Chelsio iWarp hardware, the RX
>> >>   path was slightly reworked. It now allows packet intersection
>> >>   between tagged and untagged RDMAP operations. While not
>> >>   a defined behavior as of IETF RFC 5040/5041, some RDMA
>hardware
>> >>   may intersect an ongoing outbound (large) tagged message, such
>> >>   as an multisegment RDMA Read Response with sending an untagged
>> >>   message, such as an RDMA Send frame. This behavior was only
>> >>   detected in an NVMeF setup, where siw was used at target side,
>> >>   and RDMA hardware at client side (during file write). siw now
>> >>   implements two input paths for tagged and untagged messages
>each,
>> >>   and allows the intersected placement of both messages.
>> >> 
>> >> o The siw kernel abi file got renamed from siw_user.h to
>siw-abi.h.
>> >> 
>> >> Many thanks for reviewing and testing the driver, especially to
>> >> Steve, Leon, Jason, Doug, Olga, Dennis, Gal. You all helped to
>> >> significantly improve the siw driver over the last year. It is
>> >> very much appreciated.
>> >
>> >You need to open a PR for rdma-core before this can be merged with
>> >the
>> >userspace part.
>> >
>> >Jason
>> >
>> >
>> 
>> OK I created PR #536, which adds the siw user library to
>> rdma-core. Unfortunately, when uploading, travis brought
>> up many issues with atomics etc. Is there a good way to
>> have the very same strict checking locally, since local build
>> was always successful...
>
>$ buildlib/cbuild build-images travis # once
>$ buildlib/cbuild pkg travis
>
>You'll need docker installed
>
>> In any case, sorry for abusing the PR procedure for code cleanup
>> (amending commits and force push cycles)!
>
>It is fine, this is what travis is for..
>
Jason, many thanks for the very instant review at github, very much
appreciated! I changed things accordingly with a new commit. Please let
me know if you would prefer amend and force push for those changes.

Thanks very much!
Bernard.

