Return-Path: <linux-rdma+bounces-13883-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF56BE237F
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 10:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1270540422
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768EA2FABF2;
	Thu, 16 Oct 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O03AjARc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76158212FAA
	for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604516; cv=none; b=S2ovLOjR2booRck3+GnYwd+r/n1YeierkRPpf43atRiz3y8J5FugzQnMIpyJECTPQxxmaCax98qM1by9w22l3ZYvT4LAi9Spl4sp6Fy0+3x8FxCRQv1BcVk23SnPfu8A5Zw3y/sEB3BBP0x/2SfLuVKXlVZOTTE9GIC4hhpVW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604516; c=relaxed/simple;
	bh=kkrnDxMYNrznAE3Hee5XF8MX8bDoYkPgWg1IrtAOtqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBxjICSclCT+ofrEh80k51kau+v4htYm0gVpVzegB6fGVfnRf7pCICQdPWnNj/KFlWXPv4g5vwHA2Dk2r7RD1V+1LiM372BBm8WDegU7qOC5cyZ9jdr78xlwlcTngGgXy11W9B468radVgXY8jcXkzubIHH5n7OBOWT5ml9rk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O03AjARc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-421851bca51so375541f8f.1
        for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760604513; x=1761209313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVEUrQi9cWOpaDRyBLGip7wyDUSKU6wiRqunzh1l3BU=;
        b=O03AjARc9R27ZMZrKE8djRKA3KxAYGJsRMNyCcIfOfm0XJVskqFMYGOvH2ejD0qYws
         JERlaM6Qo/06NIrHKXPky1XbjwK0LbcJIZjVPLl9pJ/ZmUsajnZ3Lh/yfelonwkORXyC
         8KmD/hOAf+M+KxL+C1SliHXXqCrh5npK9Gl6GtcDDYIaW7+VUZ5D//PTM2jQHh6XxKNQ
         ftzWrbmwf1yf6h7OPgy4nmu4VSrefeSEZisvv/aFYR7L9Z9+UWdrtRSaLpY5vnANO9qG
         uj9/DeVr1uzDySUvtszyuixQt5nwHZTfvRt3Q9qzYrI98cXhP2Do67uUrpD8mKKcOCqr
         MSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760604513; x=1761209313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVEUrQi9cWOpaDRyBLGip7wyDUSKU6wiRqunzh1l3BU=;
        b=f/lwBMknqEJLezDF+XJSDMe46tfbqw7UX+tEmfkvzmNWZbL7PMtJhipVU/9k8PlF48
         aXmNiYCi+dcw4MJubo9CoZcRQwIdZj2CKa7rZIg+iIZQXo+S4tDHdYAFIiQ+hcji7Wqd
         IOsstYpuCNxEcvZDhAGgAZXM8tq3MekWxJRk4wjtiNIg7JN21hQtCNQ3BUhJr6qiXBzm
         Um/vN/HF1Ikhl3WYSqqjF/hg3ctcaHjhWDMdbY16Yrso4hh/t80Dt0xST2dezvlVHT0D
         7kkvhE2IW+i9jGBzRP4wfK+jjr3bj2wHK3FFeOvnDBfHo91Dem3hTtmDFDLdr94W5r5N
         3jyg==
X-Forwarded-Encrypted: i=1; AJvYcCUvw8Rcy9MZdAPdE8x7BxFfajVSNepgn4lcVb1wVDQosqO4ynA6Ao92f2o0xN0uzX+O54PcZzMaj8Rq@vger.kernel.org
X-Gm-Message-State: AOJu0YyiyLIZ29f8f/xOVz6CAtpQd0YI9R8jfI0WQRqc0fsfEW5zbnKq
	7YUJtx8Ds/3diA3GTyNJU17l0OSRJHH/2zDyNIc09upZehR0C9pf7Qz7
X-Gm-Gg: ASbGncvlM0WiSBuSKwHl+WvEQ9Q3U/1fkQzwDOmGdNx1E0Wd/YG2ofPOxgHK9fIumy2
	jC4G+Oh2ijOE70hpbNVUg6kSKAk6hi9R00P9VGvhu/hthQudGRtoaJhgvClUcHDlWzmyNuQ2nCu
	WLmVXg9SvfEGu63kl9Ts+TNOImBDE8fUM2+enFZ0m9g5Mdt6emhZ3MX0b1XRz+8kp/a0ZW3RPSZ
	HK0ekmcx73boAbCnYbAvuv8oaxsHZIRAnUrx+//cqC1RCKskEIcMjkiiGRbtf2KKUki5Ph6Jv95
	zJagOKYKj/K2vCjQA8Xc5dhe601i/yolMcXyIByMf2Cq0FMtdaxxlFYKS3X24z7Zi3Cvms1mlZc
	/3avE/dbpmCX8LS9WDLkNKRcM9Faut9oycwmK89CWvFb9+1qNz3rwbdZEr/58nKyn7VatP8Zhq/
	DcOVXSIR/y5C5K6g1NBBmtwRkzkUjc8IRbmFc=
X-Google-Smtp-Source: AGHT+IFcjkeuZRpv+IRzVM4XciTTJue0s3dCI3MiZ144Kh9FyQmKyef1x1llDDTMWlEp/vC66d5XcA==
X-Received: by 2002:a05:6000:2010:b0:402:4142:c7a7 with SMTP id ffacd0b85a97d-42666ac6f35mr23068224f8f.16.1760604512220;
        Thu, 16 Oct 2025 01:48:32 -0700 (PDT)
Received: from [10.221.203.215] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42704141cdfsm42311f8f.4.2025.10.16.01.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 01:48:31 -0700 (PDT)
Message-ID: <abe2f4c3-086e-4023-911d-f2ecbdff24cd@gmail.com>
Date: Thu, 16 Oct 2025 11:48:30 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Return 1 instead of 0 in invalid case in
 mlx5e_mpwrq_umr_entry_size()
To: Nathan Chancellor <nathan@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, patches@lists.linux.dev,
 llvm@lists.linux.dev
References: <20251014-mlx5e-avoid-zero-div-from-mlx5e_mpwrq_umr_entry_size-v1-1-dc186b8819ef@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20251014-mlx5e-avoid-zero-div-from-mlx5e_mpwrq_umr_entry_size-v1-1-dc186b8819ef@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/10/2025 23:46, Nathan Chancellor wrote:
> When building with Clang 20 or newer, there are some objtool warnings
> from unexpected fallthroughs to other functions:
> 
>    vmlinux.o: warning: objtool: mlx5e_mpwrq_mtts_per_wqe() falls through to next function mlx5e_mpwrq_max_num_entries()
>    vmlinux.o: warning: objtool: mlx5e_mpwrq_max_log_rq_size() falls through to next function mlx5e_get_linear_rq_headroom()
> 
> LLVM 20 contains an (admittedly problematic [1]) optimization [2] to
> convert divide by zero into the equivalent of __builtin_unreachable(),
> which invokes undefined behavior and destroys code generation when it is
> encountered in a control flow graph.
> 
> mlx5e_mpwrq_umr_entry_size() returns 0 in the default case of an
> unrecognized mlx5e_mpwrq_umr_mode value. mlx5e_mpwrq_mtts_per_wqe(),
> which is inlined into mlx5e_mpwrq_max_log_rq_size(), uses the result of
> mlx5e_mpwrq_umr_entry_size() in a divide operation without checking for
> zero, so LLVM is able to infer there will be a divide by zero in this
> case and invokes undefined behavior. While there is some proposed work
> to isolate this undefined behavior and avoid the destructive code
> generation that results in these objtool warnings, code should still be
> defensive against divide by zero.
> 
> As the WARN_ONCE() implies that an invalid value should be handled
> gracefully, return 1 instead of 0 in the default case so that the
> results of this division operation is always valid.
> 
> Fixes: 168723c1f8d6 ("net/mlx5e: xsk: Use umr_mode to calculate striding RQ parameters")
> Link: https://lore.kernel.org/CAGG=3QUk8-Ak7YKnRziO4=0z=1C_7+4jF+6ZeDQ9yF+kuTOHOQ@mail.gmail.com/ [1]
> Link: https://github.com/llvm/llvm-project/commit/37932643abab699e8bb1def08b7eb4eae7ff1448 [2]
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2131
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2132
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> index 3692298e10f2..c9bdee9a8b30 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> @@ -100,7 +100,7 @@ u8 mlx5e_mpwrq_umr_entry_size(enum mlx5e_mpwrq_umr_mode mode)
>   		return sizeof(struct mlx5_ksm) * 4;
>   	}
>   	WARN_ONCE(1, "MPWRQ UMR mode %d is not known\n", mode);
> -	return 0;
> +	return 1;
>   }
>   
>   u8 mlx5e_mpwrq_log_wqe_sz(struct mlx5_core_dev *mdev, u8 page_shift,
> 
> ---
> base-commit: 4f86eb0a38bc719ba966f155071a6f0594327f34
> change-id: 20251014-mlx5e-avoid-zero-div-from-mlx5e_mpwrq_umr_entry_size-e6d49c18a43f
> 
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
> 
> 

Thanks for your patch.
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>




