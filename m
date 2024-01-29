Return-Path: <linux-rdma+bounces-801-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F287D840A6F
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jan 2024 16:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E9DB279F2
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jan 2024 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC311552E9;
	Mon, 29 Jan 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fE4W5cm2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122E1552E4
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jan 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543265; cv=none; b=FmmMovBAZFFKBoTGQTsekDlPNidMTOS7XUvBVoYAK5woF+QDG4B6Hmly4DqtGRzGWl/0O8JsjqqhaDEAiCZN0BCJFHa9r0YC0i1MB9VIg9sxNLdyUkFq8D4HI6IwPCa44PtekKyG3AsoxiX05EOEfoOubDLTXzqIgtHQ8q887D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543265; c=relaxed/simple;
	bh=e71rTvtPxDFneWq3ZzMAOdNG39+x8/faX2BoKUgmBvA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aMyi1rCNndBFvU/LJ5ahMG6MYDW6ZXTUJ/KioSk2I8811qp9CvCAPyBvSbNtDnRHj0WoxTUXk0G/D/PtWC4J+djdN5PkQlgCUuJ171xRlBvETmNllOtHpNBs5a3ZaPNfIwuQEE5uhRxncLW1UgyPRK6H08ZSTrRGsCmy5j3646Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fE4W5cm2; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-46b1a355f5bso420539137.0
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jan 2024 07:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706543262; x=1707148062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oJOfHja10uqFUW21l2U+7rJfVn+PAsABlarxrannHD8=;
        b=fE4W5cm2t97bHMqhisbL84cN061EiNx+Rc1358mDmTNqr4ZPK14R465cjzL8GQrlQE
         g0V/9PrqAIPRFYuCTDNOzeg0ZL8bYPEEoNKb5J8UXK5qfAvsMetASdAd5w0Nv73vSlHP
         7P4kGbcl9h8DPMIOkVo+nySBSyyjty3OqbBQ8WrOmNPR6rdcLSBi5JdC+gxCqottd/6d
         CE1q+Y6V1N1zUBCSMIhwR/J0pkBRq7DZLhFVR8ihP2nQyuqKoXLY9dgHxtR9b6TkghIj
         UaPBKuvxhgPzAZcieuCU4zaFODmz4E906YdEM/ux+rz83PYATjKI7SFzd9jgIeKKlXQe
         sShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706543262; x=1707148062;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJOfHja10uqFUW21l2U+7rJfVn+PAsABlarxrannHD8=;
        b=i14MrOFyGsQ47eGRxikZyU1DQwfTl2mbjHphkU6xU6yOHale6/wQCQBOwM7q1fh9Ix
         2eiX66IV0+LoLoZRdiv/Uc/JjC6/zAM6Zyd1c3sc+K4C6E6g7+KA36krVawEiTJpQj2G
         WWEbwTnsa68o4M8mC8EqmbwDDrvNOmz+JYagssPVVpksu6VExGX7D+MaRgHyhU6YUgHt
         NvSC7HppYziZ6Ng9GT1w2ng1u49xB62fHFQLYDND0Vmnpzi95vLHPQhPzjqKgfFVncfK
         gJTb78hKZDhWZ4WAHyLEjiGb3CGCpTFcWz7Be2ySdJEvbtDq1Qiezs56a5S0ib6Q01wD
         FP6Q==
X-Gm-Message-State: AOJu0YzotYFV6467RvxCOiz3EyYQWDln+zV6YMtOkVcSqYRkYyk5Ctxf
	/Rp7EW9N2+MufTLev4QbbO2tMKmCtTXAIJiBv/HEyymJsbDlHq7eAnEwJIlTQmPkmc/ntGWisUo
	opIOAS/O/t1Acsq99Sq9EKRxishzlf+zFTohl5w==
X-Google-Smtp-Source: AGHT+IHmSl2fS1dbhrXEFwChru7nCooY7CV03h6IE8myHIF3fsDlAyU2AUGEY1tYOslEsEj5iyXZpNsdl2G7Re3ey70=
X-Received: by 2002:a05:6102:2267:b0:46b:57b4:ad3d with SMTP id
 v7-20020a056102226700b0046b57b4ad3dmr1102566vsd.21.1706543262416; Mon, 29 Jan
 2024 07:47:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 29 Jan 2024 21:17:31 +0530
Message-ID: <CA+G9fYvYQRnBbZhHknSKbwYiCr_3vPwC5zPz2NsV9_1F7=paQQ@mail.gmail.com>
Subject: stable-rc: 6.1: mlx5: params.c:994:53: error: 'MLX5_IPSEC_CAP_CRYPTO'
 undeclared (first use in this function)
To: linux-stable <stable@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	linux-rdma@vger.kernel.org, lkft-triage@lists.linaro.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Leon Romanovsky <leonro@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Following build errors noticed on stable-rc linux-6.1.y for arm64.

arm64:
--------
  * build/gcc-13-lkftconfig
  * build/gcc-13-lkftconfig-kunit
  * build/clang-nightly-lkftconfig
  * build/clang-17-lkftconfig-no-kselftest-frag
  * build/gcc-13-lkftconfig-devicetree
  * build/clang-lkftconfig
  * build/gcc-13-lkftconfig-perf

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
------
drivers/net/ethernet/mellanox/mlx5/core/en/params.c: In function
'mlx5e_build_sq_param':
drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: error:
'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
  994 |                     (mlx5_ipsec_device_caps(mdev) &
MLX5_IPSEC_CAP_CRYPTO);
      |
^~~~~~~~~~~~~~~~~~~~~

Suspecting commit:
  net/mlx5e: Allow software parsing when IPsec crypto is enabled
  [ Upstream commit 20f5468a7988dedd94a57ba8acd65ebda6a59723 ]

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.75-143-g87ae8e32051d/testrun/22361778/suite/build/test/gcc-13-lkftconfig-debug/details/

--
Linaro LKFT
https://lkft.linaro.org

