Return-Path: <linux-rdma+bounces-16911-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBZTJJHlkmlSzwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16911-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 10:38:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E622D141FFD
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 10:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18C4D300952B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DA32E0B58;
	Mon, 16 Feb 2026 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bhQteBup"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464817ADE0;
	Mon, 16 Feb 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771234700; cv=none; b=fI6NlKFqkTQHNkzccgh22aDBnrSMZ2rJszGD5ntoZmnf7BqgSUmzh76/xtZm+YMj/zTz2BALlNago1CBBGkIYNYKTpYfV003wr0KibZTMA72FtrYzO21I5fDSakrhSergsTNDpjc2Rn3i6JQMmPovH1NrU8bbW5k5orkIGM6Hkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771234700; c=relaxed/simple;
	bh=Vq9wLW5l4G1QN/P9tcYbXvyQv5NBtix6IgJEB1L0r04=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Tu9znKFSyglB+OFc/KXp9beFe2U19JObTUhtHtmbCnq22nlWctgpheiUokyCmgRWL6bLY+3w6GnMec9xAkQyzYuLe4llWjsiqaRfXyPkKEAtumg1dU1Z887iNqnoJIrWaow6IKofdNjvFMrOAk1Kw0LtFQkSToV3BwQwUdxuf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bhQteBup; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G5tlvD1899745;
	Mon, 16 Feb 2026 09:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4HrMsi
	96Cy/CaTxkBTb5YFPGwcrGeCvkrINOL9lL5oI=; b=bhQteBupFtfXRzSU+E+ZZz
	lQc8LL+aa3xccbiF8dGfeOPU4ChlHcxXC0rHSca0IOcXEK2Av1yKj7OGLN23TOln
	2XeOVWT45A4R/yhsrr3ZjM8/PHuAqPE3u7AoXt4rEqzOcqD5/szrgrPR5NwQ2PI3
	29LNJonJUNym2robOYEBSjZU8nXW8K7ZzMZI+Iy2roJ209FOyEU36hyB66KjwHwh
	fsR6i4BLlVMX7Knwr0KBF4GEoIiAmDC/Q7NU6Tgq1njrhNdLxJL6GLM6SfUGUAF4
	oR6WAkbzP6LXot8RxSU87BRC72bvrQ2vgfxJ8mAFj1+7qEZ3DzyJ/SaCRJUDZE8Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj63xkvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 09:38:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G6KwFI012621;
	Mon, 16 Feb 2026 09:38:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb3crvy5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 09:38:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61G9c5bY1639122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 09:38:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 901A75805A;
	Mon, 16 Feb 2026 09:38:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06D075805C;
	Mon, 16 Feb 2026 09:38:03 +0000 (GMT)
Received: from [9.109.198.164] (unknown [9.109.198.164])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 09:38:02 +0000 (GMT)
Message-ID: <1ea3f9bf-c271-46bf-9310-be489ded05fc@linux.ibm.com>
Date: Mon, 16 Feb 2026 15:08:01 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.19 kernel
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <aY7ZBfMjVIhe_wh3@shinmob>
Content-Language: en-US
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aY7ZBfMjVIhe_wh3@shinmob>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 02YJqje8rZh6Zxh_b1ejtbuICIlU1eHN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3NiBTYWx0ZWRfX9dagytfdB2m7
 bKVX8PF5kCI102GPsiD8smfB0skHb92xNYXGmf5V+TG42gMwGuumR+xBk7adniDnWObPhul965g
 R1+Qr4rF3u0OQFUMgr5a54DoiTFhfeOpcaTPn1nC5yQqQ0EzAXn27BuRSIAb76S4DludVtomvzL
 WwOpVzXbT73mJicNYEBB1wPox3vMiR/3g/TYkQXGOCZvJSBwixJBIENJmZifFmNS5B8Tdxoxn5j
 SfaOmXdWs8+agR9m5jbHeV5BcmlkSMGog9ngEYTZbxQU+VprHkauo5N4FKmFVjBR48CtUB+xiMy
 VTXbAB3/OjY27okuhCS5QjWSLHxV/kKNfHfch9EzUunp583SWtp8p+ZbSJEO1BLgohAwxdgAmOx
 hL5LRql2FCIpm1l8i+k8VkAAxkUSJ/tJkRE9/A7kRa+4WS6pxrimrM1YJhKheyXF85KPT6hyyij
 E57bNAz+jjthMEyVkLw==
X-Proofpoint-GUID: 02YJqje8rZh6Zxh_b1ejtbuICIlU1eHN
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=6992e57f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=JF9118EUAAAA:8 a=pGLkceISAAAA:8 a=rseCahVfaKpdl2NpX8UA:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160076
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16911-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilay@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E622D141FFD
X-Rspamd-Action: no action

Hi Chaitanya,

On 2/13/26 1:27 PM, Shinichiro Kawasaki wrote:
> Hi all,
> 
> I ran the latest blktests (git hash: b5b699341102) with the v6.19 kernel. I
> observed 6 failures listed below. Comparing with the previous report with the
> v6.19-rc1 kernel [1], two failures were resolved (nvme/033 and srp) and three
> failures are newly observed (nvme/061, zbd/009 and zbd/013). Recently, kmemleak
> support was introduced to blktests. Two out of the three new failures were
> detected by kmemleak. Your actions to fix the failures will be appreciated as
> always.
> 
> [1] https://lore.kernel.org/linux-block/a078671f-10b3-47e7-acbb-4251c8744523@wdc.com/
> 
> 
> List of failures
> ================
> #1: nvme/005,063 (tcp transport)
> #2: nvme/058 (fc transport)
> #3: nvme/061 (rdma transport, siw driver)(new)(kmemleak)
> #4: nbd/002
> #5: zbd/009 (new)(kmemleak)
> #6: zbd/013 (new)
> 
> 
> Failure description
> ===================
> 
> #1: nvme/005,063 (tcp transport)
> 
>     The test case nvme/005 and 063 fail for tcp transport due to the lockdep
>     WARN related to the three locks q->q_usage_counter, q->elevator_lock and
>     set->srcu. Refer to the nvme/063 failure report for v6.16-rc1 kernel [2].
> 
>     [2] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/

For the lockdep failure reported above for nvme/063, it seems we already had
solution but it appears that it's not yet upstreamed, check this:
https://lore.kernel.org/all/20251125061142.18094-1-ckulkarnilinux@gmail.com/

Can you please update and resend the above patch per the last feedback? I think
this should fix the lockdep reported under nvme/063.

Thanks,
--Nilay

