Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57030187C11
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 10:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgCQJbe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 17 Mar 2020 05:31:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbgCQJbe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 05:31:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02H9LlmZ082716
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 05:31:32 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.119])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ytb3p5wqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 05:31:32 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 17 Mar 2020 09:31:30 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.182.123) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 17 Mar 2020 09:31:25 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020031709312372-264063 ;
          Tue, 17 Mar 2020 09:31:23 +0000 
In-Reply-To: <20200316162008.GA7001@chelsio.com>
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org,
        "Nirranjan Kirubaharan" <nirranjan@chelsio.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>
Date:   Tue, 17 Mar 2020 09:31:23 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200316162008.GA7001@chelsio.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-KeepSent: 1E443249:92333F66-0025852E:002FF389;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 61547
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20031709-3975-0000-0000-000001E93232
X-IBM-SpamModules-Scores: BY=0.067541; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.005233
X-IBM-SpamModules-Versions: BY=3.00012763; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000293; SDB=6.01348900; UDB=6.00719409; IPR=6.01131308;
 MB=3.00031260; MTD=3.00000008; XFM=3.00000015; UTC=2020-03-17 09:31:30
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-03-17 04:52:51 - 6.00011128
x-cbparentid: 20031709-3976-0000-0000-0000359854A8
Message-Id: <OF1E443249.92333F66-ON0025852E.002FF389-0025852E.00345020@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_02:2020-03-12,2020-03-17 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>, sagi@grimberg.me,
>hch@lst.de
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 03/16/2020 05:20PM
>Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
>"Nirranjan Kirubaharan" <nirranjan@chelsio.com>, "Potnuri Bharat
>Teja" <bharat@chelsio.com>
>Subject: [EXTERNAL] broken CRCs at NVMeF target with SIW & NVMe/TCP
>transports
>
>I'm seeing broken CRCs at NVMeF target while running the below
>program
>at host. Here RDMA transport is SoftiWARP, but I'm also seeing the
>same issue with NVMe/TCP aswell.
>
>It appears to me that the same buffer is being rewritten by the
>application/ULP before getting the completion for the previous
>requests.
>getting the completion for the previous requests. HW based
>HW based trasports(like iw_cxgb4) are not showing this issue because
>they copy/DMA and then compute the CRC on copied buffer.
>

Thanks Krishna!

Yes, I see those errors as well. For TCP/NVMeF, I see it if
the data digest is enabled, which is functional similar to
have CRC enabled for iWarp. This appears to be your suggested
'-G' command line switch during TCP connect.

For SoftiWarp at host side and iWarp hardware at target side,
CRC gets enabled. Then I see that problem at host side for
SEND type work requests: A page of data referenced by the
SEND gets sometimes modified by the ULP after CRC computation
and before the data gets handed over (copied) to TCP via
kernel_sendmsg(), and far before the ULP reaps a work
completion for that SEND. So the ULP sometimes touches the
buffer after passing ownership to the provider, and before
getting it back by a matching work completion.

With siw and CRC switched off, this issue goes undetected,
since TCP copies the buffer at some point in time, and
only computes its TCP/IP checksum on a stable copy, or
typically even offloaded.

Another question is if it is possible that we are finally
placing stale data, or if closing the file recovers the
error by re-sending affected data. With my experiments,
until now I never detected broken file content after
file close. 


Thanks,
Bernard.



>Please share your thoughts/comments/suggestions on this.
>
>Commands used:
>--------------
>#nvme connect -t tcp -G -a 102.1.1.6 -s 4420 -n nvme-ram0  ==> for
>NVMe/TCP
>#nvme connect -t rdma -a 102.1.1.6 -s 4420 -n nvme-ram0 ==> for
>SoftiWARP
>#mkfs.ext3 -F /dev/nvme0n1 (issue occuring frequency is more with
>ext3
>than ext4)
>#mount /dev/nvme0n1 /mnt
>#Then run the below program:
>#include <stdlib.h>
>#include <stdio.h>
>#include <string.h>
>#include <unistd.h>
>
>int main() {
>	int i;
>	char* line1 = "123";
>	FILE* fp;
>	while(1) {
>		fp = fopen("/mnt/tmp.txt", "w");
>		setvbuf(fp, NULL, _IONBF, 0);
>		for (i=0; i<100000; i++)
>		     if ((fwrite(line1, 1, strlen(line1), fp) !=
>strlen(line1)))
>			exit(1);
>
>		if (fclose(fp) != 0)
>			exit(1);
>	}
>return 0;
>}
>
>DMESG at NVMe/TCP Target:
>[  +5.119267] nvmet_tcp: queue 2: cmd 83 pdu (6) data digest error:
>recv
>0xb1acaf93 expected 0xcd0b877d
>[  +0.000017] nvmet: ctrl 1 fatal error occurred!
>
>
>Thanks,
>Krishna.
>
>

