Return-Path: <linux-rdma+bounces-8409-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21215A54615
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 10:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9EE1891C6A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9E920897D;
	Thu,  6 Mar 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky03cjFU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD78207E12;
	Thu,  6 Mar 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252762; cv=none; b=E6mxFVlE5g41OdLuSwLNyA2e9aUAyeO3PgOxfwPSegZ132WjbnXz4sYk4lkIj7iCVlW57dqWZI/9ECNXV9IPEqIJpqacfin2v4Xz2KYO477CkEmqsEMWdHpxc1xXILgWlUyG1tYCGnjTeKVjgcYyTiKUxS81if1x3P/LwIvZdeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252762; c=relaxed/simple;
	bh=UDC5YwHosXS413z3xkeJUhvnABGe1BRBfyYOdjylq9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oc0JEWijzrGMqSsc9h1Jm1EzliO6/mfIo9h3IGGGQTsYMM9CBHh+Th3fLZHSqcH1Q0CurQXwUONp0JcwBXAf0qios+dtVFT7brCCUpZl3P6lp5xvn+i4X6cqrLxslX8I+MAu7YHyWTo7VzFLi4pShjECMCkMRVQV1XgJPlFGllw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky03cjFU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bbb440520so3773915e9.2;
        Thu, 06 Mar 2025 01:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741252759; x=1741857559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mxkm6D/oQZJezrbn3M8SnWSt5I0pn2MRcdvwk8MF8x8=;
        b=Ky03cjFUGWyWg04qw+nWg0VFfiDmZ82u0k2FLnHcaBa1s/82bY4eGbcUcS2OMB0Xfm
         E4x+UZRbg3SQNFBUs8sA06SySpbn1fal4cqyVwmSlYDPtXU5FjIZxlrP2duIQP8hUWcM
         b3XFrZjreIx66k+xaEw0LvvejrvWZSkHykFPGsXJzonTKrFwc8CL8RqZVPt4A2fQ8cvD
         A+rT/Emdqyre1QxB/wBhqDgW9Yhd5xraQApP/r6cSXcxJ+7p/6xyS08ZI22OQ1JsLq8c
         irjdeAGlAej/BCi3D5/BwUdn36BTe5iSHQdiyv0rQizTSOef8FzYCsNo4DMeqQYNZ76x
         SZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741252759; x=1741857559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mxkm6D/oQZJezrbn3M8SnWSt5I0pn2MRcdvwk8MF8x8=;
        b=JbPmXz/CwLMzaShyzoh6O+yW0iRDL319FOwjJ16PQq70xxOLr7ZocL4Lw5MxCfGsQF
         zz3BxMG/gdig85nX5io7qpGWQ3XaIAgejokVqyzgUWfqhbCocJpACEZsX85hjRktScVX
         rBNGZ5H2ZdXb5+u2rI47+ZD7XRT1Ty2Q3XH0OPQh1CelRJXahGkpdyitaW8MTVhkYsCV
         GJI30U1Yc4YEBV461mHn2GnAs/fg5YjzcTt17Osdyl22Msn2+lHlBlnNYZhxTgDpHn0r
         CmXvlN9EmR3jyNtk17nPqCIFax31JsOonhS7vww1WQRqvpJJ4mSb4JG0B396hz6GHm+/
         ZoBA==
X-Forwarded-Encrypted: i=1; AJvYcCUUmJobqlFqUjt5IZJ84sdpZ/tNDRdISqq7xrPn4cWHNQLDW1tKEEVe2bBRwUiwoW7g8EsONoqZ@vger.kernel.org, AJvYcCUzaR/mxfvFrXr1gfAnfU/ZEuu0kJTHe3I4aJ9u4BB2SDuBC6bYbSVs/ivBML8hTBO3oLi+p00mzESl/Iw=@vger.kernel.org, AJvYcCV/qWHIs2ae0s9DUmBYz6CQkH6Gs0h7pl2jbO5Sj6WkV5pFnf8eHRTuw0cl7VrL3qUA9ryMVE+dLZAH6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvnaEUzLigfqiM1Q2Dn3vxB+ILBAiynaYkRJLQXDcogGhDQ2jm
	J+8VdoubFheuoI2apJo+jMlLrXzSURvG/xgkix3wRlGlB8rMYmuY
X-Gm-Gg: ASbGncu9FzezKwfL6NhnD03EBMv33aLSZkLs2jhOr+jR+lMpxXlHYj+ULIjZpiyq2IJ
	2IaFQ8zwx2rL4DYJ+yvfC9sR5x5AAk7SIMCJs/KO9lS4el1qxSHgfXiFCTl65DM4MqbZnXKaX8B
	n31XRWKDWnajFKkhgIZ35yn1Oa5KHMyFnIF0GhSgnw8YXwOsrcUAxYeFFnITPwCCm+bhFAHnyrl
	92YDmYmGzmTVVDBZ8rtywUiLi1UhyEIyrzuOoVJFMP/cdReMsJFzVhQs09B7XqkaWD9dSwp/hki
	9ICXgxSai9N5UP6/wRS+yCONF4Rnyn10N8N+DrhseNfhrFP+hD7M0e9eN/Y4gRYScg==
X-Google-Smtp-Source: AGHT+IHvxrp7OvNbksyH4NexsetiRs1WEtAgahqn/oPDFsxSQWMo+9dlJKmgRBkVVv+oIO3DwkB/gA==
X-Received: by 2002:a05:600c:35ca:b0:43b:ce86:b31a with SMTP id 5b1f17b1804b1-43bd29bd205mr49158555e9.22.1741252758687;
        Thu, 06 Mar 2025 01:19:18 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b0425sm13943855e9.3.2025.03.06.01.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:19:18 -0800 (PST)
Message-ID: <90902747-b976-4653-8d9d-0371f168bdbb@gmail.com>
Date: Thu, 6 Mar 2025 11:19:14 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5: handle errors in
 mlx5_chains_create_table()
To: Wentao Liang <vulab@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250306085402.2503-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250306085402.2503-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/03/2025 10:54, Wentao Liang wrote:
> In mlx5_chains_create_table(), the return value of mlx5_get_fdb_sub_ns()
> and mlx5_get_flow_namespace() must be checked to prevent NULL pointer
> dereferences. If either function fails, the function should log error
> message with mlx5_core_warn() and return error pointer.
> 
> [v1]->[v2]:
> Add Fixes tag.
> Target patch to net.
> Change return value from NULL to ERR_PTR(-EOPNOTSUPP)
> 

Change history should not be part of the commit message.
Please move it to under the "---" marker below.

> Fixes: ae430332557a ("net/mlx5: Refactor multi chains and prios support")

Same problem existed also in mlx5_esw_chains_create_fdb_table(), before 
the refactoring.
Please refer to the original patch where issue was introduced, seems to 
be commit 39ac237ce009 ("net/mlx5: E-Switch, Refactor chains and 
priorities").




