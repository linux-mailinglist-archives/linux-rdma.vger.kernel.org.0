Return-Path: <linux-rdma+bounces-11607-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E428AE7475
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 03:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DCA17B00E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 01:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F0118A6C4;
	Wed, 25 Jun 2025 01:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VicK1ch9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAC72E630;
	Wed, 25 Jun 2025 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816099; cv=none; b=Cv/ah+oUz7qLyTAQqVEpZ8Wvb0GMFFlSBii7+yjsvIql16D578xpjvelqPqP70Utjxl/PUX4hgRwcAVTVziB7JhwG+JSKACfwWyxdb+ZMaFjrRTmNRjweiXlqQmb+QoBWVj+eY1Un2J4Vxrz6PbZ9qe1iOu7eH+p5Ktp1eqJxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816099; c=relaxed/simple;
	bh=El93fx7f3JKcXtm5iRmabWXGm+3VxAjWT8rWFVMqtCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqZyfrNha6ySlUQua4DHz2PF241AHpiztC3EOysxLfsgsb7aFlNLDj3PK41VlzDv51SvHRViFGGyvXvs80SYSje7FPs9yePiKFcQ6RuFK7zsrisKzkKOU2BfF51zLGyosIAcbSGhrTyPTxM3taldXngIB/h4174wqRWsLJwx1zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VicK1ch9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OMifNW027078;
	Wed, 25 Jun 2025 01:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oqSnbLDjzi3NFx8s2S5ELE7rxuIsv/ajHUIFTwTo2Mw=; b=
	VicK1ch9oj0FeI3CBrkCfd3pq72snKO7fLCtclQECUO1PqKnTH+XBFf01XaRvZdL
	CDDd1LYd6K2mbKsAwRMSQo35Qwy0G7Pxc4sHkxkYebrQoZPPpmSdMsl2PMwSuCXb
	t4p62qvzgA+sAgPcl+DXhG313K/OF7sBPrOZWvdw9nrejk80/eNfU0iFMl+IptQt
	3oQtSzg5nYkfYltCngpqMFRIEY6+meShP/hi6bdb5d1orC9ML2R0mAO2YDlnztoS
	90BgwxrirnJUj1hm0IuHeLdcN+KtO2m4DJ7M80RRJdeDQEEd4XyWUK5WS3RYwIKV
	Poi8/lTCc0YiTXAmkgsyFw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1d7vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 01:47:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55P0cBP5024408;
	Wed, 25 Jun 2025 01:47:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkre6ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 01:47:55 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P1lr8d038193;
	Wed, 25 Jun 2025 01:47:54 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehkre6k4-3;
	Wed, 25 Jun 2025 01:47:54 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Laurence Oberman <loberman@redhat.com>, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fix virt_boundary_mask handling in SCSI v2
Date: Tue, 24 Jun 2025 21:47:33 -0400
Message-ID: <175081602599.2445192.10779450904820173704.b4-ty@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250624125233.219635-1-hch@lst.de>
References: <20250624125233.219635-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506250012
X-Proofpoint-GUID: ldCMXiF-PIMyYCCSI0Z9jf1me1BDNs_W
X-Proofpoint-ORIG-GUID: ldCMXiF-PIMyYCCSI0Z9jf1me1BDNs_W
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685b554b b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=2kHY24pOABEqYHhHmQ8A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAxMiBTYWx0ZWRfX5O397ZDxfzVb ntwsQk7ecbbBXrME/QktoY/VoF0vVgOhTNeiK/u85Yazp6B4u17UcWOXkl+Bt4lpfFzDqVBWo0k UAk/MaWngvdhiCbKoPQiliIvkfEUKCs76HouFgbzaOW7IcDSaxAxmXPr6j9b+CebijY7hqf4tlf
 IhLt/zalxd/q4/LG3o0vkinrLVjxKn+0b2vB4BXuOHNr+Ic/fSuQUxI52uAFAX9Mcim+A2CRLkM rkmKfjZqvtNdaSMSlSN/C+Al9GInXYfq0X0ABU4aWD1f4iAo2e8s9pu02QppVmbo2930j18neeL 8H8afQ/Cy7ZMGlIRk7bUX+zh4jM+gMgUKeFcdmDlZdRj65ozZ/K09DshI8CoY6dLsLFEbFAw4W8
 YYUz+tS7lgi5hxk3o8jDDJ5Te9MHB3GCA6vj3+wgQu+/PlcwRLtaoh0X/+S1s30z9wQjfBlO

On Tue, 24 Jun 2025 14:52:26 +0200, Christoph Hellwig wrote:

> this series fixes a corruption when drivers using virt_boundary_mask set
> a limited max_segment_size by accident, which Red Hat reported as causing
> data corruption with storvsc.  I did audit the tree and also found that
> this can affect SRP and iSER as well.
> 
> Changes since v1:
>  - improve the srp commit log
>  - slightly simplify the limits assignment in hosts.c
> 
> [...]

Applied to 6.16/scsi-fixes, thanks!

[1/2] RDMA/srp: don't set a max_segment_size when virt_boundary_mask is set
      https://git.kernel.org/mkp/scsi/c/844c6a160e69
[2/2] scsi: enforce unlimited max_segment_size when virt_boundary_mask is set
      https://git.kernel.org/mkp/scsi/c/4937e604ca24

-- 
Martin K. Petersen	Oracle Linux Engineering

