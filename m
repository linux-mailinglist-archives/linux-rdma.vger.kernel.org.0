Return-Path: <linux-rdma+bounces-7609-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70BBA2DEB8
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 16:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415B31887132
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13AC1DF733;
	Sun,  9 Feb 2025 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="umvhQtFk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D6F9FE;
	Sun,  9 Feb 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739113862; cv=none; b=H90strh/nGW9WtH9Vjnbo0ajq/RhjQhGt28mc7abuS88ontFocrZmxhyIxQrOFsXjiyU8kIowiA6Gq25KLUCXerZNRUgilZhY/0mX3VJd8vA1m5QO0Jm1Zm9rUQsC4lnZ+hSHlptKV4KFYVz66eHWURH9VvcEO4RNFGrc4jhpvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739113862; c=relaxed/simple;
	bh=Pw4A9EPtu6M+CznVZfsow6MTIebmDOlA4bH9NLWTaKc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=j+YGYHXVz31afHvkbYT9JAmCpmrIyYf3ZUjGXsvKDc7uua+nhTUpjPG9yNhTgPFfbZYVXkd9Lf3T7/QxwdtY8OTDUZq05QD/AMgbv+Q9nvHiAoFeQhXxq9+T7djhGff1oSdtV+FVuscIbJVjg+jR2cOl/nZ50YDefqqzlpQKxGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=umvhQtFk; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739113849; x=1739718649; i=markus.elfring@web.de;
	bh=g+85RQ49D14pcg2rQ7TtGa2VAdHK1hPQ3J5/ITKF/WA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=umvhQtFkJKgEp7S9+0oDsmUmnjV+vi2ERNdv2wvGbItwxEeKfvUdPEwVKwoxd6sL
	 01oEc35CzzQk/C2ZayrMW/d01J1Q/6Jumi53MO/gX5yLSIcfXZtvEISoRyKsnRR19
	 Hav0HtDDG26Xrxh+zwiIemCxyUlDwN41sXkOy2ypAvbBkVzi2aN9znJcvtW48XHQq
	 /HQzHkhc9Zo0NJLK+nVrcRVZ9kApA6WsXPzsXCZ5xo63UzCLJgaruqa2FTmBhEyY1
	 tinTKK+zvmSBeqbnhiuNI6xqo2aAcxolUKtp9N27Nx098PtxZMcWp+BaY07XHXJhh
	 yeTWntG8AR3Yj/GMoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.5]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkElP-1sx7su09tp-00cJ6d; Sun, 09
 Feb 2025 16:10:49 +0100
Message-ID: <7692fda2-f9a5-4381-b1a8-f949543c0a89@web.de>
Date: Sun, 9 Feb 2025 16:10:48 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-rdma@vger.kernel.org, Cheng Xu <chengyou@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kai Shen <kaishen@linux.alibaba.com>,
 Leon Romanovsky <leon@kernel.org>, Yang Li <yang.lee@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [RFC] RDMA/erdma: Avoid use-after-free in erdma_accept_newconn()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NA+UC7Qcrq9UtmA+RHMOp869eZiVVcuDInHKov2+UH89LDoaMyY
 u2e64DgcxrjjlYXhEOCevq4c6JvFdeOOv93jypj2l23DXZkK9ZYZ7xvWTXt+suR6wYPc2PN
 F46Sh9TaV6iO0pdDU6gwSm2W/ySNbho6AfgPjBnSf8E1roCvYLuNld8n5/puDK9LnZuurMP
 Ia9EaKnOFcp3FwjldGOdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:18ZA4r85Zbo=;EwgIFKo/HgaCN4a56LVXXBTrez0
 ft7w01R5PC69J4Ey20IchS8+53f+3cCI2nj6sgfHogpdVsFSXtNv/hneDyra3j7KAz5GrLnOx
 W0anZV2/GtAAH/vYvaRkdzdzPK8PuofgedjsatB2po2yXV3TtzRrAcGR2cb9Tt68Vq3lN6myH
 cT5WMycl+q2ldPp8thcM+WW4ria2TE7p94fRzbZ5Zvxsv39QqBeKqCQij+gpfIHnD8+08bA87
 iC7mM1R5noTvsFsWYpt+kIoRkyPNwcBNPJVhChex+Z77RpYo0cqlcKtkNnMj6WIuhXa0qEbWe
 4UmGppfBpzMst3it8E4cS9qKZ3AIXg4MGKfMSxgp/RnPo0waqUnkWK0mVjrRDgb2slTiZ/yz3
 UM6X8+Nt9PEyqOTUJ6HqKmhPSHyNCMe8WU67u6mtvT1SDaH/gsdaM9cG1fpV/dXvz0LyOMbsy
 gGT5hSKIULP9uUu7AHMAIvUoBaDtUZKgC5AZdxbCnC+P2I3Ndqh+lgzI8m9ntquk6043KL4Hy
 ul9YDY/GSxS3WezFKA+OVaigXK776OeS+sQ9IJEueYtV+aUgX7IDn0hp2ym4GB/U83YM8b7Wn
 BtFlkpBw+U1Ei7/gqWrUc1rRTWSdOlOFf38Gp4YvcRosLNi536cdoqSmXPJSHjAgzo31DOCFt
 Vw5l5mb4oiRvV4gGNwVsxK+VIDYSG9R34A0N6seXXA5l6gXHzwwonUNOE1JDzcjNJCaJ3nMbg
 FiYh+Fz3+y1T4HJQ8T3sC5vmOgwsuowTLpfgndAgiMOoGJTxLDYX5BVlE4a1TPn6KJHqKsS20
 dDCm9nm9CP+P620xeDk4wJqjnXK/ga9YFGaNwgpf/gNxWbglO0mLAgz/p1oI0X6Hog2PIduHP
 MFvhFWWqgHXmTDNVk9OL3Ej5713OjcrCBEChyo004QHNPxhT7JN7fad8sw5dJG/sUEEGGEIh+
 gTggLn6zoZz1GarO9a3sxDOLGEDX1izDOk76bZvU/mRlLibYK8Oh//DFmhxIUu/E/JC6YxAqy
 dfV6SBWIL+Y40aoT2nlERT61XREJLCtPCGtfDCK97X8Lg05bOZ6FvakZvaunb51b7MjxWHAHJ
 gqCc7ZnoN3hpJcz53OrjnNR+7IeUXiNn9Pf9VDli5sVR4WMP5pRVaxtAqEOaqAflxoJIrGR6M
 CXyx95XxwOsOQYQ7QyGJhKNUDEoKfYOLngt1YHo/enYOxQNYykJac/JSET7XnCSDhn7S60JIi
 hqPrS1UUVeWMceQ7up9DBHyVoiYBT/Gi4XMxPAaFN3PmfGAHohSnApz6JrTIIZxZAhLDDIyhY
 exC2G1RPdVIHnIJRaHAXTfWqzBA1oOQzXbTS/aW+znmllGLaKaRw1PUyO4l13577ec/utI/Zf
 ixNgRGgh4u0fTag/nFwlo1tby8w6t7494ypWXVGrVii8b7Mp6RqgvWJHsza5FOjth8gcUVG38
 /FPCR5N4WymtRnf+5IR4REQe6D54=

Cheng Xu pointed out that the following statement combination would be undesirable.
https://lkml.org/lkml/2023/3/19/191
https://lore.kernel.org/linux-rdma/167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com/
https://elixir.bootlin.com/linux/v6.13.1/source/drivers/infiniband/hw/erdma/erdma_cm.c#L707-L708
		erdma_cep_put(new_cep);
		new_cep->sock = NULL;

Are there contributors who would like to fix the commit 920d93eac8b97778fef48f34f10e58ddf870fc2a
("RDMA/erdma: Add connection management (CM) support") from 2022-07-27 accordingly?

Regards,
Markus


