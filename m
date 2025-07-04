Return-Path: <linux-rdma+bounces-11898-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EDFAF86FA
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 06:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DCF544035
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 04:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7991F3BAC;
	Fri,  4 Jul 2025 04:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLCpcvxM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1561F12E0;
	Fri,  4 Jul 2025 04:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604924; cv=none; b=XjdZfjnUlEkniKPBOtpI1qV/CZbMxbtTUDdI+pBdXIY/ovI3//8smtnu3Nv/4LT9ZaTD/e9NRa+D+m1ix1sLh90H5EWMbR91NvUycfMr9a5iaIiGykn94cxmHe8ZLDYIMKcxL7ca1KXN/ogBikuATdCZKyrzkVtDf982MZhGbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604924; c=relaxed/simple;
	bh=uz7E/3lyyWcGy/zaFzZm3Xi8fMrEATIP1mwzow3SP88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCHGvanJJWnE1+3zBzIZAoN4l1Ty+OVlGdqKa6jsFEuctd3SegDBaXFvzb6tHf4QsZ6aHxrOG86fK03C6Q3T6SdaAmzIcw/SXLk5p9qW2M/BMYYyfin0+NLAD/+ADayxrHFRFtjiHNS8vVg13kbnEtA0JTVcwb7YW4ZXRpQ6PW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLCpcvxM; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a54700a46eso236635f8f.1;
        Thu, 03 Jul 2025 21:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751604921; x=1752209721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txRfSTqQyK4OCVcc+lfj6TlKM+lidxFZ6/G4s0wfT/I=;
        b=XLCpcvxMrEabbv8sdkUpRpvmOriQbddvdqjywfJ+aUCUCF3MqHHDQlVFLwNzBX+rmg
         WLEcFQaXw67sNzX0r8sKb478U5gYfR/CfDhfYGU/xM+pDMm/uFpkkXttVsvGLuXqN6t+
         YXTUUR2b5R5bC9ijx5w+G/TB3wKc1FZYhZuCjaTa2imFRuLZd649rsOeA/qbu7YpEGuf
         VD4iggAGYDkCvO0hLGQZIoUm1KFXHHSBw9kn3hz2tVKQa5307WJ/56vs/RNwdb5lfivg
         m7Pulf4VrzNPtbKrtjwIm2TprQLSG22mNXffMxZ02ld1Q+PHC82V8oq/TYF0M1h0U87I
         U2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751604921; x=1752209721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txRfSTqQyK4OCVcc+lfj6TlKM+lidxFZ6/G4s0wfT/I=;
        b=uYJ/w5rVrqsDknmEJF3I3WuGhFkce9LdH1ZJQdJV4F6dWQIYPMzM6wbkxNbV8H1RLR
         5UwiUK3ryILde9cZOjx7C648hIgMH4oOjh5nueIRrxJ1JlvUbHHTrctJz7dOdUdW8igM
         azWJ+Al5hr6IsB0zVjNNkeo2ctM2DIKhmCS903O+ZK00K5eEHsGdjqqQouWdY4Knl6qz
         e9lG/kzVnVrONpB47zT+XgZRuscxVreapx2NyYy1C43EVH7Ou/CahkHRXEiyrxc4rX7g
         nJLgTCKMMFVznDIwMYyKZMMzBjNUDY+/0ss4Oh4L25QMVVeXYafGkq23ScF7B0QV/se1
         Ok4w==
X-Forwarded-Encrypted: i=1; AJvYcCWCKdKTY3u6yqYIK+vq+q9xEPumqkLFbm3Q5yew+gVzQ51rEpkWla082YvrUXFlpG958kikjWBzy+9sog==@vger.kernel.org, AJvYcCWHhkKFQmpkQfMcx5/Wi6aNmlcTJIvd6tgfmgkiN6fzoKxL8hRuyY6NXNtADA9nejQ27y8nRcfw@vger.kernel.org, AJvYcCXh7SafGD3sNHt3p+Dop7OJ6M4m1pjznxI+jfjoHUMq/6kJ7ukvnOMdRl7upIhP/E2iatlr4no7Vem1FJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1unaZyYwNI7AFnc5RRAxwT1RG6vYCJKsa8rU3c5rN0wDQjWRA
	7cqsyf7+FKbCrUEjWgFsT0La/u80cpQqby3HmhdJabn5bHa8XIe5Ot1Q
X-Gm-Gg: ASbGncs69wIO/Szdn1krBIoXJzkRf+i/8hXm6abUBxQExiHKiNWR8/vsTICxgKFgcXR
	lHlmRe4cm/bOp+49/N0FhYtwQv16A6tnNLvPkXbzrUfjUXVS1VuIv4cWqiA5fDeG8zdxPpUZnZx
	m3XDesIOUiDp3iaEt3y4skFz5CezcMQqtxA5HyDVMKTGMj52rif+D0Ue2CVsMrG2VflxfgIFZs6
	0kyiVQ7gVdT4uT64gvLd+2DXt8e5pSd2caSsjVKpo3j4tP20U/78BgVIoUPZ37X5WAlfvbDkTGl
	xXroaFXMknGNhApACtNvznqq41an+WS52S2/j3MrYXIb8LaW8pNzrRtBMIlqFZZhEyXu+X4Fy8a
	TOZStK0TBFg==
X-Google-Smtp-Source: AGHT+IFQcgEw3R2KRF1A7GhhZlgVAZV3jrIJ+fYUelomene8qoxtvz7tJUhKq5adyjUGUlsgMre6jg==
X-Received: by 2002:a05:6000:18ad:b0:3a5:3b03:3bc6 with SMTP id ffacd0b85a97d-3b4964f1f10mr718155f8f.28.1751604920594;
        Thu, 03 Jul 2025 21:55:20 -0700 (PDT)
Received: from [172.27.52.43] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1893479sm15047175e9.39.2025.07.03.21.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 21:55:20 -0700 (PDT)
Message-ID: <15c4c8d9-e9d8-4c4c-ad13-c734bbb04bb3@gmail.com>
Date: Fri, 4 Jul 2025 07:55:20 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pull-request] mlx5-next updates 2025-07-03
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1751574385-24672-1-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <1751574385-24672-1-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/07/2025 23:26, Tariq Toukan wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates
> for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 

This is V2, previous PR submitted by Mark:
https://lore.kernel.org/all/e7a83ea5-d70b-4c37-8068-a73293b51262@nvidia.com/

V2:
- add a bug fix for the fs patch.

> ----------------------------------------------------------------
> 
> The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:
> 
>    Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git 02943ac2f6fb
> 
> for you to fetch changes up to 02943ac2f6fbba8fc5e57c57e7cbc2d7c67ebf0d:
> 
>    net/mlx5: fs, fix RDMA TRANSPORT init cleanup flow (2025-07-02 14:08:18 -0400)
> 
> ----------------------------------------------------------------
> Dragos Tatulea (2):
>        net/mlx5: Small refactor for general object capabilities
>        net/mlx5: Add IFC bits for PCIe Congestion Event object
> 
> Patrisious Haddad (2):
>        net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain
>        net/mlx5: fs, fix RDMA TRANSPORT init cleanup flow
> 
>   drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 44 ++++++++++++---
>   include/linux/mlx5/fs.h                           |  2 +-
>   include/linux/mlx5/mlx5_ifc.h                     | 67 +++++++++++++++++++----
>   3 files changed, 93 insertions(+), 20 deletions(-)
> 


