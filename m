Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D376242045
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407738AbfFLJIt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 12 Jun 2019 05:08:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405378AbfFLJIs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 05:08:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5C931C0101058
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 05:08:48 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2v4m5tt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 05:08:48 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 12 Jun 2019 09:08:48 -0000
Received: from us1b3-smtp03.a3dr.sjc01.isc4sb.com (10.122.7.173)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 12 Jun 2019 09:08:44 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp03.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019061209084347-248500 ;
          Wed, 12 Jun 2019 09:08:43 +0000 
In-Reply-To: <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>
Subject: Re: receive side CRC computation in siw.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Tom Talpey" <tom@talpey.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 12 Jun 2019 09:08:43 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>,<OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 33525C92:4FC26BD4-00258417:002E634C;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 7635
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19061209-9695-0000-0000-0000067D7DF5
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.352659
X-IBM-SpamModules-Versions: BY=3.00011250; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216835; UDB=6.00639828; IPR=6.00997935;
 BA=6.00006333; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027275; XFM=3.00000015;
 UTC=2019-06-12 09:08:46
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-12 01:43:39 - 6.00010038
x-cbparentid: 19061209-9696-0000-0000-000067C2A993
Message-Id: <OF33525C92.4FC26BD4-ON00258417.002E634C-00258417.00323CE4@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Tom Talpey" <tom@talpey.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>,
>linux-rdma@vger.kernel.org
>From: "Tom Talpey" <tom@talpey.com>
>Date: 06/11/2019 05:11PM
>Subject: [EXTERNAL] Re: receive side CRC computation in siw.
>
>On 6/11/2019 9:21 AM, Bernard Metzler wrote:
>> Hi all,
>> 
>> If enabled for siw, during receive operation, a crc32c over
>> header and data is being generated and checked. So far, siw
>> was generating that CRC from the content of the just written
>> target buffer. What kept me busy last weekend were spurious
>> CRC errors, if running qperf. I finally found the application
>> is constantly writing the target buffer while data are placed
>> concurrently, which sometimes races with the CRC computation
>> for that buffer, and yields a broken CRC.
>
>Well, that's a clear bug in the application, assuming siw has
>not yet delivered a send completion for the operation using
>the buffer. This is a basic Verbs API contract.
>
Well, it is receive side. And it might go non-signaled.
The case I looked at was a RDMA Write which got placed
into a buffer which is concurrently being written by
the application. Yes, the Verbs API claims adapter's
ownership for buffers referenced by posted, but not
yet completed operations. At target side, there is no
outstanding local operation being completed by an inbound
WRITE (as a difference to an inbound READ response).
That's why I am unsure.

>> siw uses skb_copy_bits() to move the data. I now added an
>> extra round of skb walking via __skb_checksum() in front of
>> it, which resolves the issue. Unfortunately, performance
>> significantly drops with that (some 30% or worse compared
>> to generating the CRC from a linear buffer).
>> 
>> To preserve performance for kernel clients, I propose
>> checksumming the data before the copy only for user
>> land applications, and leave it as is for kernel clients.
>> I am not aware of kernel clients which are constantly
>> reading/writing a target buffer to detect it has been written.
>
>This, too, is an invalid application. The RDMA provider is free
>to write the target buffer at any time. Many implementations
>take full advantage of this by placing received RDMA Writes
>in memory prior to validating their packets' checksum(s). If
>there is a mismatch, retries are initiated. The realtime
>contents of the buffers, prior to a completion, are undefined.
>
Right, placing the data first and checksum those only thereafter
adds another level of confidence the buffer contains the right
data. Something a offloaded RDMA engine will typically not do
though. And as a result, some applications out there (such as
qperf) assume to have the right to write the buffer anytime.

Furthermore, a SW implementation of iWarp, such as siw,
is not fully integrated with the transport (TCP). While
MPA detects the CRC error, the segment cannot silently be
dropped and re-transmitted by the transport, since typically
already acknowledged to the peer. With that, an invalid CRC
will cause a connection loss. siw will just send an RDMAP
TERMINATE frame with error code 'CRC mismatch' as defined
per spec.

Thanks,
Bernard.

>Tom.
>
>> I also checked other kernel code using skb_copy_bits(),
>> which also needs to checksum the received data. Those code
>> (such as nvme tcp) also does the CRC on the linear buffer
>> after data receive.
>> 
>> The best solution might be to fold the CRC into the
>> skb_copy_bits() function itself. That being something we
>> might propose later?
>> 
>> Thoughts?
>> 
>> 
>> Many thanks,
>> Bernard.
>> 
>> 
>> 
>
>

