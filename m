Return-Path: <linux-rdma+bounces-9368-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C170A8563F
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 10:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59967900861
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F7226F47E;
	Fri, 11 Apr 2025 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XmKKRHs8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FDC1F0982;
	Fri, 11 Apr 2025 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744359151; cv=none; b=K7r5BgvE08F3ygRRWprgCeunNPMsCsUP8godGFjViwvzw1kZ4pqM9NokbyD+Uw1iSLqKVfr+mwv2Y4uQdCuI6YA7oocF5KGZcQa30H2PWo5WvzWq1RICD3Vbrr5ZpspXjbTo/Bk0KpuB2svcK4eIjPmM8Fx13P4bd92Hrxb3VeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744359151; c=relaxed/simple;
	bh=N3v23ps0BMU0zoGkJGEymMvqf/aSSi6y2ah1N1AxHaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk4ucvUmi/BwqhvzUIcw1+RnkvBTA1lSZh1skM37c13lKH707+9MkNIEJUFmdZvMnP57nGeZWoVDw7TNjf6DCzUN8RnaMn4DLwM8Apd8Z47OBf3wZbJkMbJAd7+vMGRhC5wWa2Xs/7xwnxkl4lQ62AfSm3kULZN8ZfnMxm3ZHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XmKKRHs8; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=N3v23ps0BMU0zoGkJGEymMvqf/aSSi6y2ah1N1AxHaM=;
	b=XmKKRHs84Pz7LwJgsbA8+0s0A4dodbjE23LIJkkQRlp567AchN7n1k/yYwxL3E
	did4x9DQg640FGxjzuREwbLl6UZ08SBWpbwd1wbkpi1KMh7AeOOmI/LDBnXjavun
	ImKqbnbrpwmx8pXStNAjWNcLuGagd5B7rl9ZIHk17X3Jo=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBnVRRDy_hn3isnFw--.47534S2;
	Fri, 11 Apr 2025 15:56:53 +0800 (CST)
Date: Fri, 11 Apr 2025 15:56:51 +0800
From: Honggang LI <honggangli@163.com>
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc: "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Fix kernel panic for fast registered MR
Message-ID: <Z_jLQ0c6t2LigbFJ@fedora>
References: <20250411071141.82619-1-honggangli@163.com>
 <OS3PR01MB98657E6B788DBC4B11115102E5B62@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB98657E6B788DBC4B11115102E5B62@OS3PR01MB9865.jpnprd01.prod.outlook.com>
X-CM-TRANSID:_____wBnVRRDy_hn3isnFw--.47534S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUnksgUUUUU
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbBDwksRWf4xqp3MgACsb

On Fri, Apr 11, 2025 at 07:31:51AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> However, this issue is already addressed in the for-rc tree.
> Cf. https://lore.kernel.org/linux-rdma/f845e90c-50ff-4e0f-9b73-55a704ba934f@linux.dev/T/#t

Yes, you are right. Please drop this patch.


