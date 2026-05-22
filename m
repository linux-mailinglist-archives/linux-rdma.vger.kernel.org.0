Return-Path: <linux-rdma+bounces-21153-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NpCDH9AEGrzVAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21153-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 13:39:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D09C05B321F
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 13:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36A8630074AC
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 11:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706F43E7159;
	Fri, 22 May 2026 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RDY5Q2rI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51F3D5C3C;
	Fri, 22 May 2026 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449980; cv=none; b=bHlLR32emNDEleKLrPb7VwfDHKNWCpXO4aZlycpGBYs7WLlGyWxlFkZLmXqrt3cfC00VbN55aBrYjXWrjVbcLEMPdHYUBKb0TXuVKG8TJnAruNWjT+5LRUJyhEiQLG69xF3fEpgr4Pc3wMzQrMzqlyDLbcNVmbX64ymJ1244OFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449980; c=relaxed/simple;
	bh=TClq4/7SK1Z/xXxGZYduXmjm5g0RIgm2fVR/m+t+U+Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k60j2nI6VDCW4cZj9C/K/xY8G//zNl2gCoFTRZSbWzgsBeFlM2gPjIYh51B4fG39ReXlmMhGBINraEbtR4FOF41sF525DxRsc0gemn/7Hwz9RuiFxadsIix4IrFtIxgi3imNgxK2jYdQt4x5n2HwgTvf+ild5USlFSlSifiRxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RDY5Q2rI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MBb1wX850123;
	Fri, 22 May 2026 04:38:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=S/TaEaEXks8X7iosRcdyIvl0K
	E1XLE0/69GEjxv9P10=; b=RDY5Q2rIdUca65Vzo5ncJFUlA9pKtHxMG9sTy0SzG
	2rmylQlL6VxBPpz43x+yXBekIUHPlGbNJ5xdVZio8rQz7Xx0gxWX9GMsY+wsWh2u
	QuCcWOJ3PY0hrbPqNjNwovxCjAoW+umesVTGZpgz7mHQmDPqfWaTl+zSQTtnPdKO
	ksx4uNvMulpZS/yUoHwDjitcFZfni3YxEiRNyXB9XESHVycHmiDkESMTJJKV7SPY
	dnvLr0dwpOqYZEedoct0UfN9abaI/UI6fpZHf5tLXa256NNcvPAaf7hSfmWalRC4
	jTTFXsNginy8RwxVN/M92r7IJSM21NOgJGDty5crYm6Yw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eape5g02g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 04:38:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 22 May 2026 04:38:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 22 May 2026 04:38:56 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 364AF3F707A;
	Fri, 22 May 2026 04:38:47 -0700 (PDT)
Date: Fri, 22 May 2026 17:08:47 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <oss-drivers@corigine.com>
CC: <akiyano@amazon.com>, <andrew+netdev@lunn.ch>,
        <anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
        <brett.creeley@amd.com>, <darinzon@amazon.com>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
        <idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <leon@kernel.org>, <mbloch@nvidia.com>,
        <michael.chan@broadcom.com>, <pabeni@redhat.com>,
        <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
        <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
        <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
        <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v16 net-next 1/9] octeontx2-af: npc: cn20k: debugfs
 enhancements
Message-ID: <ahBAR7jtDPyDzJFK@rkannoth-OptiPlex-7090>
References: <20260521095303.2395584-1-rkannoth@marvell.com>
 <20260521095303.2395584-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260521095303.2395584-2-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNSBTYWx0ZWRfX5z8YNEeYeERy
 2Lx250kAWm9S9YxbgZt0nK5E7n9HNZ+Jb3RtIAWzsqsoNU4ix/w+JaTvZHrANuWFylTF4EJNlPR
 1j69QM8JQujH6T+A8vCKtRLDFAuSXCrIdaJJKXLxyjJG5vo++qVgzDVBrFg1ERpAJcwVsDibcjs
 ki2DUvaKC+CgklXYWtNfAqXA1aF4/vbwA1N1AeIMAAo+jeA1b31BxSzDJdL//Cj6/0ck9xFjEcz
 9dHZFSumaSLMic9/Evp1LhvZ8n3RQoxkdz3bAWdH9NpcS2kybbYbBapVyhlje2Hv7+9ZF/gFWeb
 8pvK/fKhHHR2ac5MKYO2yrmJQYgYVDCIFk70zJ3iba0aEg+UsGzdB45heVWNL0A0mxL9CXMx58f
 9XNToh3X84Nl6DOB2cotluqBukBfUcOz3wVPm/lno7/RJxmn9r+yPM+1cEukmGi1l+yalNoosPW
 Zqhc7QofKWcTAWdMZ7A==
X-Proofpoint-ORIG-GUID: b6nlHL4DDvEYP7ZTEW50KdUVq7wqpyXb
X-Proofpoint-GUID: b6nlHL4DDvEYP7ZTEW50KdUVq7wqpyXb
X-Authority-Analysis: v=2.4 cv=H9PrBeYi c=1 sm=1 tr=0 ts=6a104051 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=AJ3TjQoutCXb-s05bgAA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21153-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D09C05B321F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-21 at 15:22:55, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Improve MCAM visibility and field debugging for CN20K NPC.

[ ... ]
>> +#define DEFINE_OCTEONTX2_DEBUGFS_ATTRIBUTE_WITH_SIZE(__name, __size)		\
>> +static int __name ## _open(struct inode *inode, struct file *file)		\
>> +{										\
>> +	return single_open_size(file, __name ## _show, inode->i_private,	\
>> +				__size);					\
>> +}										\
>> +__OCTEONTX2_DEBUGFS_ATTRIBUTE_FOPS(__name)
>[ ... ]
>> +			delta = stats - dstats[bank][idx];
>> +
>> +			snprintf(buff, sizeof(buff), "%u\t%#04x\t%llu\n",
>> +				 mcam_idx, pf, delta);
>> +			seq_puts(s, buff);
>> +
>> +			dstats[bank][idx] = stats;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&stats_lock);
>> +	return 0;
>> +}
>> +
 +
>> +/*  "%u\t%#04x\t%llu\n" needs less than 64 characters to print */
>> +#define TOTAL_SZ (MAX_NUM_BANKS * MAX_NUM_SUB_BANKS * MAX_SUBBANK_DEPTH * 64)
>> +DEFINE_OCTEONTX2_DEBUGFS_ATTRIBUTE_WITH_SIZE(npc_mcam_dstats, TOTAL_SZ);
>Does this code use single_open_size() to force a 1MB allocation to avoid
>seq_file buffer overflow?
>For dstats, the show function modifies state by updating dstats[bank][idx].
>If the seq_file buffer were to overflow and restart, it would skip entries
>or report zero deltas. Bypassing the seq_file dynamic resizing with a 1MB
>upfront allocation per file open wastes memory to hide a seq_file idempotency
>issue.
>>
if i understand it correctly, seq_file idempotency issue occurs only if .next() function
is a custom implementation. In our case, we are not using custom .next() function, so it wont
happen in this case.

