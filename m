Return-Path: <linux-rdma+bounces-1836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB6089BBD4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 11:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446771F22C57
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E524C3D0;
	Mon,  8 Apr 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HAJzuBNs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA46FBF;
	Mon,  8 Apr 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568877; cv=none; b=moryqkQcdiLEyK5K/K0brse4E7NuIOAIs72Vcr2hRccHwapNo0bVxf/LooN+Is6OPV4/XGfRpFOkqExVOASIKK7XkFVtW9I4aroRLKfXD6WO/VisXs2O3AAvI/5RHGWEmrDlXvLEIu5JscDxzs5SPYYrkiE/dFCszzL2xLhhiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568877; c=relaxed/simple;
	bh=frFJy5Iffrice8TATlhPSbyjdDx4lsgbTrENNwTKGyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i8XH5rCxRcD6cvrNJh51X1W+DFIp+m0dwXIkt1nQpdW44mpJQb9LtDJVWUF8xXk7ptt0DkJKhmNmC/emYf+cvuln0Yt8aSa37tx6AX6EvBIOfaEf/4NbQdHJQAYLxeC32T4Iy+oxwGxmyI1NrK5hnle7lKvHcv5TXF7H71XzDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HAJzuBNs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4389674X018763;
	Mon, 8 Apr 2024 09:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=HRb08lOvL/RkQcGPtpnIO47HiV3JbnaC5Kla4WlkdPg=;
 b=HAJzuBNsO2JwyXcSUPA5KKjMXoa85ATgDBDMdlUVrWrD4LTczUD9Nzq1exAuSBYIXiod
 e0MbeFjiTJ8BhZHNrUhGGDzWKY8EITc7XduqdLDZ5GctKya+kVyoKq/IkOu0SedUx2z5
 pQp8LeJGmQfs2CM+LTbmD/KJRvxg9VmuuBuJ1NKV4C1xxrojFpma6UqwA03Fy2zslw5J
 vQkdyyQm/5xiBkjpSpVWZG0r2JfzA51m5ovZNnFXMysbeE8Tuv+bGvb6/0yFAENxHcVu
 qAKQ1mFWZTC2QuNZ6UtiF13rTIvo2INwrArwDWHsJE6MYCmUQBSAMU8Fvb7Q48Tb74E1 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xcahageb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:33:21 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4389WAD8027701;
	Mon, 8 Apr 2024 09:33:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xcahageav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:33:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4388CHai022664;
	Mon, 8 Apr 2024 09:33:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbhqnqanr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:33:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4389XFRb40632662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 09:33:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7ADC2004B;
	Mon,  8 Apr 2024 09:33:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43F2D20040;
	Mon,  8 Apr 2024 09:33:11 +0000 (GMT)
Received: from osiris (unknown [9.171.19.167])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Apr 2024 09:33:11 +0000 (GMT)
Date: Mon, 8 Apr 2024 11:33:09 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, keescook@chromium.org,
        vkoul@kernel.org, marcan@marcan.st, sven@svenpeter.dev,
        florian.fainelli@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, paul@crapouillou.net,
        Eugeniy.Paltsev@synopsys.com, manivannan.sadhasivam@linaro.org,
        vireshk@kernel.org, Frank.Li@nxp.com, leoyang.li@nxp.com,
        zw@zh-kernel.org, wangzhou1@hisilicon.com, haijie1@huawei.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        afaerber@suse.de, logang@deltatee.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr, andersson@kernel.org,
        konrad.dybcio@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        patrice.chotard@foss.st.com, linus.walleij@linaro.org, wens@csie.org,
        jernej.skrabec@gmail.com, peter.ujfalusi@gmail.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jassisinghbrar@gmail.com, mchehab@kernel.org,
        maintainers@bluecherrydvr.com, aubin.constans@microchip.com,
        ulf.hansson@linaro.org, manuel.lauss@gmail.com,
        mirq-linux@rere.qmqm.pl, jh80.chung@samsung.com, oakad@yahoo.com,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        brucechang@via.com.tw, HaraldWelte@viatech.com, pierre@ossman.eu,
        duncan.sands@free.fr, stern@rowland.harvard.edu, oneukum@suse.com,
        openipmi-developer@lists.sourceforge.net, dmaengine@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 7/9] s390: Convert from tasklet to BH workqueue
Message-ID: <20240408093309.9447-A-hca@linux.ibm.com>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-8-apais@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327160314.9982-8-apais@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iEx_GL3tt0mvzHnM4XY0RznJTIWn8Sle
X-Proofpoint-GUID: YubKogQl91W9lviSSqhJG7ZeEe8HfK38
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxlogscore=816 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404080073

On Wed, Mar 27, 2024 at 04:03:12PM +0000, Allen Pais wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts drivers/infiniband/* from tasklet to BH workqueue.
> 
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10

I guess this dependency is a hard requirement due to commit 134874e2eee9
("workqueue: Allow cancel_work_sync() and disable_work() from atomic contexts
on BH work items")?

> ---
>  drivers/s390/block/dasd.c              | 42 ++++++++++++------------
>  drivers/s390/block/dasd_int.h          | 10 +++---
>  drivers/s390/char/con3270.c            | 27 ++++++++--------
>  drivers/s390/crypto/ap_bus.c           | 24 +++++++-------
>  drivers/s390/crypto/ap_bus.h           |  2 +-
>  drivers/s390/crypto/zcrypt_msgtype50.c |  2 +-
>  drivers/s390/crypto/zcrypt_msgtype6.c  |  4 +--
>  drivers/s390/net/ctcm_fsms.c           |  4 +--
>  drivers/s390/net/ctcm_main.c           | 15 ++++-----
>  drivers/s390/net/ctcm_main.h           |  5 +--
>  drivers/s390/net/ctcm_mpc.c            | 12 +++----
>  drivers/s390/net/ctcm_mpc.h            |  7 ++--
>  drivers/s390/net/lcs.c                 | 26 +++++++--------
>  drivers/s390/net/lcs.h                 |  2 +-
>  drivers/s390/net/qeth_core_main.c      |  2 +-
>  drivers/s390/scsi/zfcp_qdio.c          | 45 +++++++++++++-------------
>  drivers/s390/scsi/zfcp_qdio.h          |  9 +++---
>  17 files changed, 117 insertions(+), 121 deletions(-)

I'm asking since this patch comes with multiple compile errors. Probably due
to lack of cross compiler tool chain on your side.

If the above wouldn't be a hard dependency I'd say we could take those parts
of your patch which are fine into the s390 tree for 6.10, fix the rest, and
schedule that as well for 6.10 via the s390 tree.

