Return-Path: <linux-rdma+bounces-9380-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B49A8600B
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8F11891D82
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5E41F237A;
	Fri, 11 Apr 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hvdO1zan"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3F1865EE;
	Fri, 11 Apr 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380384; cv=none; b=ZoVJp9FRLnPSYAD0UM47x89vaAqT+/o6H4GHb2dXYFR4RJidL58fRI6TkWdfs2Qgmexn4BWE5zVqmraX5z1+LAErBYagWQJ+aJHMip9BOaWF1UrNVSfJWFCtMDMGe3+V/bJzJVVRhsYaLbXCAgteMlzUAIbNKAObcV++c3lB5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380384; c=relaxed/simple;
	bh=9cqZdTdGMUBt7Rph2nfcNpf4nK9yVw+u1OjWgO7NIUw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Nj/kA+Y30DCk2eam4F1Ut/vOMK+FClUCGQqzCNNayjTRBWPPqFSpohibZYIftc216gs1Ka3AIAinWLkpQwdPThbIB1Wchpv8ORIFrOsE7nA6eEwOF+LBwOpLmZ/C3qluaQAY57jPXAyDt+DDYjyQ8NmTwzXjVD9sPiMqu4zw94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hvdO1zan; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744380378; x=1744985178; i=markus.elfring@web.de;
	bh=9cqZdTdGMUBt7Rph2nfcNpf4nK9yVw+u1OjWgO7NIUw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hvdO1zanezD/o2IjYg06dbe7NAY9cFu9Cp2PvTKntTnK5o9Q/kKNhflcpquE3SX8
	 Mg0plsgQbRoaIYTbNO3zlE/BzX3ZKoZ3VkWMNM7JMBnMyW1t0Q8zzsgUjvKzEzkw7
	 Qa/B+wZXJ1VfUHuDeTfHkMyX7xMaO7lo9SjNouM3AjjS1x0zmeXSj9Vwf89y6sqd4
	 KHAaNpwTHVdzXiWUYgYdH01eCoNtJ3DyM/BlS3ZWuhf85egUlUvOxpBwOdgYoxF34
	 ItstO0Wj/dGVb1z+jsdhw510CxNm28Up5DfLC9sMKxcQGazlqXR+w7PTzZxCY2Z9q
	 4w+q8UJdlC2D9c1R4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.66]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mt8kN-1tABON04FN-00wl8s; Fri, 11
 Apr 2025 16:06:18 +0200
Message-ID: <1784cc08-918c-4745-bc7d-22a0217fea45@web.de>
Date: Fri, 11 Apr 2025 16:06:16 +0200
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
References: <20250411131431.46537-2-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v4] net/mlx5: Fix null-ptr-deref in
 mlx5_create_{inner_,}ttc_table()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250411131431.46537-2-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hwKkeL4ea4YlMxXKdVeEjUCvOe87wC43IxzlfSr4ys29JlOCp+U
 mk1U751DCZk3Gdh6CQsxzqdF3s6Xu7ENmHufromhgsY0gXxpyaq4DxwcICTvS17yoRBYbgv
 V/jbqc2u7Tltk/ZiY3gIeE/3g+PUhmQvYmmfhs0oLqW3ncmgerJUgBd+U4iVclT33bpTXMo
 B5TEB/z8wVlQeJkbcwkBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xGRtdU2csCM=;7C0jJlyxH+/Py2yhnU6zHSgSDZ8
 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

> Add NULL check for mlx5_get_flow_namespace() returns in
> mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() to prevent
> NULL pointer dereference.

Can any other summary phrase variants become more desirable accordingly?


=E2=80=A6
> ---
> V3 -> V4: Fix potential memory leak.

* Do you propose to complete the error handling for more function implemen=
tations?

* Please avoid duplicate source code.

* Can an other enumeration style become nicer for version numbers?


> V2 -> V3: No functional changes, just gathering the patches in a series.

Would you usually expect more than one update step then?

Regards,
Markus

