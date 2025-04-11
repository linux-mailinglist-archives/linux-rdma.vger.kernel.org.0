Return-Path: <linux-rdma+bounces-9379-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73373A85F95
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 15:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2031733DE
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656FB1DE3AD;
	Fri, 11 Apr 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NsEf5ibF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56FA86340;
	Fri, 11 Apr 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379150; cv=none; b=oT8S+KedLRZBrUem/jqt95tQy4aG/0/myKt3ZviIVRiQWzNGuMmTpOhbuUkc3M8eloi3Xj8iw1B7C8/LavyQgVCzEEFNn5RnSXSQ5ak+1lKR8TjUcbwPLISxWQc92ZEhQ4P3/lsFKycD+C41w0NAu4BgJkJxmSd8L3VGvO56aJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379150; c=relaxed/simple;
	bh=8RXUTUAXs48P+XfMT6Eeype/W7T7auhLUdNE7QHMiLU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=gxa+jUcHFssrDihSvTnvqUqePY2re2JqXpRH7Vc5osBSHK+WiglWof/H3cuC6Kyz7qUAEXsQ/iuNLH7DO9qiykfydoy/IIQyGv3QAADpDm4aMJX2LihTVYf6nmCq+hoGTCmVUt1S3t2jhvWAoCt3w3d+M1kBzBrRmCfVAcTKxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NsEf5ibF; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744379118; x=1744983918; i=markus.elfring@web.de;
	bh=8RXUTUAXs48P+XfMT6Eeype/W7T7auhLUdNE7QHMiLU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NsEf5ibFAroZmxFItzfEGrvLyLLpc9eHVkLBNN58rRd8nhQ2MBK43orIUQl9h05P
	 xTSBgKSBKCj3Fs8SCALAWmAJLXfDbszcx5FDGASFwLB8He9e7HP11SpnXRGZ7KDT+
	 +eIOEcsfYKg/oDR8iqd4NEdLgM8BBYBtHvMrcb+lK5RJp8rPAAFlVU3qJsRmOQIVH
	 mQlGkqrjtD4CkaRlBQjrlm+qCSOAZ0treigKwML/QfHpVRsAuAnnPJZTEf0Ub19+T
	 4BeNVRsYkOmnzV5pCGldRe8kzOYC4DEx0ChaRI0NiCMazFQsbX85ewqqumxhI5KUx
	 NQAr2evTyhNze7I/lg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.66]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1JAm-1u1Zzz3lE2-006AZY; Fri, 11
 Apr 2025 15:45:17 +0200
Message-ID: <bbea0c47-9bc3-48a4-97cd-c422d6b40804@web.de>
Date: Fri, 11 Apr 2025 15:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Amir Tzin <amirtz@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Aya Levin <ayal@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250411131431.46537-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v4 0/1] net/mlx5: Fix null-ptr-deref in TTC table creation
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250411131431.46537-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZpggF9rjZ+uYBQnNaORYfGEJB9tI8aLneYYvKqn2CR6BnGmZIm+
 a3x3sbSUuyskFoeljJLmPZOc+QoIV3ripONdE/ep9qDZKn4bqfjNubXxzrlDYlQD0HDp2yM
 dsBtKsC+p6Otg4h62X5q8+h4776XeRhjSUQRJz9sC7EhiZSTq2hoizwGpXY6rw/v4Ow0PlE
 8DMXQuqIqgWE+WmzFxYcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8vHTHU/rFxQ=;P1l4cleXLQ+7pZ+T3XPpV4UoeRJ
 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

> Henry Martin (1):

You may omit a cover letter for a single patch.

Regards,
Markus

