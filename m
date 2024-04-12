Return-Path: <linux-rdma+bounces-1920-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497828A23A1
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 04:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA951F21BC0
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 02:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BABD2FE;
	Fri, 12 Apr 2024 02:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WM+TyW4r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94C6AA7;
	Fri, 12 Apr 2024 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887570; cv=none; b=lfzVe5HPytpNO1+jfQBnew+nWPzwWLV0ja4xR8QEaUVpwWV97/oyV0tbsz0yhfsWNSqpxmNEEgLAvHuB4xw9UzTwU8l5lW3Tvhf1PWoDMRlHm6WiZWDsCeGFwt9S3iL45yvojpG8z5+SJFKkLZ6CvoYH7+70knn0GVzdlwuAEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887570; c=relaxed/simple;
	bh=aEoL6rKKCvTLMxooTa5IZCl3dhZS8a58XFdV9z0DRDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMrB3BpoRUU5Vk34oyrX8vEipAsBRp+6wNPhQfIcSoIPuvgQd7WHeDY7sapes01uc7YfaPdVYxH6Vnz4vlocDMXkWveBHid+Cj80EG9tvsoFToRwkBv0SUHONA63eZ8mZEwuhs30KndqL0eW13HDyDADbwPVdvu7a1Kvhbwl1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WM+TyW4r; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43C1U0UE014810;
	Fri, 12 Apr 2024 02:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=xwYRaxiFWquBhWbskhSYaTqpZAhykH/cmH/6Jc6WzHQ=;
 b=WM+TyW4raQ4ya05K8XioeGRjSwNLzM5SPPG5vRPDFIIq+Y7e5b1/uDFw1uDb5yonfTJB
 hRbcW99ZiLAHZRtDZw01OCuDeIfyqV+00NDqVtOk+sEpRiuom/j65WHj9PCcICjECoHm
 EPa1rXY/2bycPOpse3Uv4oY9EDRe3VM3jgy61jty7GW5/BnXrbu2lCZHT+HNjPXz2RrE
 UAMeSZh0/XsZl3fnCMgPZv6jrCbtFeIKRju9cZChQXIneKbXu2piSp4aQ6KvGc2Z+Kg/
 YYspAeRaHJCR3NtaF5mKXMeiXmYBR2GQcv4eYYnQkJAOHK3f5kesD3Fy069SwqrY2SYl OA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax9baq80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 02:05:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43C01jPY040068;
	Fri, 12 Apr 2024 02:05:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavugmd3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 02:05:33 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43C25UFs013100;
	Fri, 12 Apr 2024 02:05:33 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavugmd1x-7;
	Fri, 12 Apr 2024 02:05:33 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-scsi@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Doug Gilbert <dgilbert@interlog.com>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/8] scsi: documentation: clean up docs and fix kernel-doc
Date: Thu, 11 Apr 2024 22:05:14 -0400
Message-ID: <171288602656.3729249.13953839600529757224.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408025425.18778-1-rdunlap@infradead.org>
References: <20240408025425.18778-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120014
X-Proofpoint-GUID: L0F8yIw-Iyir1sXCL4c_lfKYTx4PnGg0
X-Proofpoint-ORIG-GUID: L0F8yIw-Iyir1sXCL4c_lfKYTx4PnGg0

On Sun, 07 Apr 2024 19:54:17 -0700, Randy Dunlap wrote:

> Clean up some SCSI doc files and fix kernel-doc in 6 header files in
> include/scsi/.
> 
> 
>  [PATCH 1/8] scsi: documentation: clean up overview
>  [PATCH 2/8] scsi: documentation: clean up scsi_mid_low_api.rst
>  [PATCH 3/8] scsi: core: add kernel-doc for scsi_msg_to_host_byte()
>  [PATCH 4/8] scsi: iser: fix @read_stag kernel-doc warning
>  [PATCH 5/8] scsi: libfcoe: fix a slew of kernel-doc warnings
>  [PATCH 6/8] scsi: core: add function return kernel-doc for 2 functions
>  [PATCH 7/8] scsi: scsi_transport_fc: add kernel-doc for function return
>  [PATCH 8/8] scsi: scsi_transport_srp: fix a couple of kernel-doc warnings
> 
> [...]

Applied to 6.10/scsi-queue, thanks!

[1/8] scsi: documentation: clean up scsi_mid_low_api.rst
      https://git.kernel.org/mkp/scsi/c/c3bf7774fa24
[2/8] scsi: documentation: clean up overview
      https://git.kernel.org/mkp/scsi/c/293fcea539b5
[3/8] scsi: core: add kernel-doc for scsi_msg_to_host_byte()
      https://git.kernel.org/mkp/scsi/c/fcf8829fd993
[4/8] scsi: iser: fix @read_stag kernel-doc warning
      https://git.kernel.org/mkp/scsi/c/11d99e91846a
[5/8] scsi: libfcoe: fix a slew of kernel-doc warnings
      https://git.kernel.org/mkp/scsi/c/d9c911824145
[6/8] scsi: core: add function return kernel-doc for 2 functions
      https://git.kernel.org/mkp/scsi/c/8d523f0f5383
[7/8] scsi: scsi_transport_fc: add kernel-doc for function return
      https://git.kernel.org/mkp/scsi/c/007c04e53526
[8/8] scsi: scsi_transport_srp: fix a couple of kernel-doc warnings
      https://git.kernel.org/mkp/scsi/c/a2530eb748ff

-- 
Martin K. Petersen	Oracle Linux Engineering

