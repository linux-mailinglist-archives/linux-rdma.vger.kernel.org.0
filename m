Return-Path: <linux-rdma+bounces-5854-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B66809C1826
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 09:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4304AB23127
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1330C1DE8A8;
	Fri,  8 Nov 2024 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWCJbZGu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8841A2631;
	Fri,  8 Nov 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055097; cv=none; b=k7zFTog/87n6icVSamdI3vlvCy7QiTibgj+Tb44lhWTT5Z30YiaEWXqNcu3Qiw7FNUgpeqbnOOXJ6eQlhKDLjzK9BsmHr0iOeEdkqncNim1IBSAjbyYDmvLk0dRRiU9mOqcjKX9iSxS36bFq9t2PBFGqZHARtT0ICSUpLh73+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055097; c=relaxed/simple;
	bh=iwamr/dMh3k2/I46HgUh3becGE1nHJi92Buqgn3qoZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBGj944GOXKGbag3aqgYXnGCyDCjQxotGq16PBG86r5Tudv5IvypKqTAKmIqEuR8ZAnaDW7AfrqDuuyAVK+m8X/RZrO4Ixo20qqnx3Uu3YAJF+w+iCUlNXdPtqoCeG7BlaUsyXIGZYjDSn6bgY48ol2CycaZQG+P9SkXQGuqEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWCJbZGu; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460ad0440ddso10536941cf.3;
        Fri, 08 Nov 2024 00:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731055095; x=1731659895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwamr/dMh3k2/I46HgUh3becGE1nHJi92Buqgn3qoZw=;
        b=YWCJbZGuVbjBXT0xlu4KmYlmGPZWpDWgcQkoxfAq7r3v5Vp9bC8LuNCW2K3WesWSC9
         K7q56OiDzPzSB5kPUVykxQ83SzOYHwPjH9w03qLjdkhGeO4cz6yAI7ecYZYnfGAkc4oz
         1y7HMCx+cLT6wpmIOnEJtN4Phj9/lwoFTp9tJbMKx7cSVfJ5UvZLmY9Z7h+UbZz8HNIO
         fLk3qTcfau8zfi+vudjwVSJNu64LBdF2slAmKmpczNfa6iVW9gVMNKk5uIiTIOM8CGR4
         HCcHahmT4mekSL5Y5QP1aJCrizBH2hoBndDto/aZXs5jX60HSWP5+wozfobTf6EzabOQ
         P6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731055095; x=1731659895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwamr/dMh3k2/I46HgUh3becGE1nHJi92Buqgn3qoZw=;
        b=lb03cwwNn/9tUHfjjmDUJh+9dVMpeAbzjmE0/Gp9r1dywUjZ40I1gNv98GLSSFt83b
         WxeKgRByq9DQMratGyYq7fEtJcPs0bKjo+8V2LlyxnJjGqj32Vm2eECXOHjhDocqmlNW
         3/iDh/mptVWL2jifLX4KuNH26cKFxn5Jig3JJcazIs89oV0ryCCgjFE26USvCK2BNHGw
         gkAr6lGyUnFHSw6tVAp0FCk3ZJrVdH2or3oUmO4rfUq27yaBRpchaO4PMcYCk4XL/W1v
         bvdgjZm4A0UtdSyMn6/BhL9oWAVMiOow+H64YTG7mMegsff951e7ASEoCDzSSI/M6bKy
         q1dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjt/bypDUw3mZWndYCotdsqCiqtoX3O0sT1Cv89TFtYNlgz2yghU7TTZmp/EEoPJg4y4yk1lf/@vger.kernel.org, AJvYcCVxQd+wKMiIPyFYIADyrk4nLMcBkjpyYJ3DiGsLbiqxS8ikze3hBbKtEN4HuoTl7u7Ig3h15fRVEYGw@vger.kernel.org
X-Gm-Message-State: AOJu0YyWNl4MTszfaP8mEN5HUC2ba2Cy02aue3I+0MTIqaPZ4pIHU8pX
	Ct/BAHwQUnwqCES4Tlq1J0Dcg42E+Hv/QuFE1wwVj/kN583YiVtD4qkaOYiRdtosfB6PqNSTxdk
	QTmOOvS2Gue3JBrHSHUHhylHt52Pm5gEeiqH0fA==
X-Google-Smtp-Source: AGHT+IGhoswV9CyClzsmwJWWeJCEpKP1BBghvYfzoL8xrIBaRdW4iXi2wVUZFGb+pRZmIxxuds/TTLNfe98hd/xQhFA=
X-Received: by 2002:a0c:f207:0:b0:6cc:b4:5dcb with SMTP id 6a1803df08f44-6d39e1f49e6mr22689246d6.47.1731055095293;
 Fri, 08 Nov 2024 00:38:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106064015.4118-1-laoar.shao@gmail.com> <b3c6601b-9108-49cb-a090-247d2d56e64b@gmail.com>
 <CALOAHbDPbwH7vqV2_NAm=_YnN2KnmVLOe7avWOYG+Rynd295Vg@mail.gmail.com> <9b3af2dd-8b56-4817-b223-c6a85ba80562@nvidia.com>
In-Reply-To: <9b3af2dd-8b56-4817-b223-c6a85ba80562@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 8 Nov 2024 16:37:38 +0800
Message-ID: <CALOAHbCPDFs1D_XxoTmPushq70unz6UDn978Ati2sMV4fZ_MHg@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5e: Report rx_discards_phy via rx_missed_errors
To: Gal Pressman <gal@nvidia.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, saeedm@nvidia.com, tariqt@nvidia.com, 
	leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 3:23=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrote:
>
> On 06/11/2024 13:49, Yafang Shao wrote:
> > On Wed, Nov 6, 2024 at 5:56=E2=80=AFPM Tariq Toukan <ttoukan.linux@gmai=
l.com> wrote:
> >>
> >>
> >>
> >> On 06/11/2024 8:40, Yafang Shao wrote:
> >>> We observed a high number of rx_discards_phy events on some servers w=
hen
> >>> running `ethtool -S`. However, this important counter is not currentl=
y
> >>> reflected in the /proc/net/dev statistics file, making it challenging=
 to
> >>> monitor effectively.
> >>>
> >>> Since rx_missed_errors represents packets dropped due to buffer exhau=
stion,
> >>> it makes sense to include rx_discards_phy in this counter to enhance
> >>> monitoring visibility. This change will help administrators track the=
se
> >>> events more effectively through standard interfaces.
> >>>
> >>
> >> Hi,
> >>
> >> Thanks for your patch.
> >>
> >> It's a matter of interpretation...
> >> The documentation in
> >> Documentation/ABI/testing/sysfs-class-net-statistics refers to the
> >> driver for the exact meaning.
>
> I think this documentation is outdated, a more recent one is in if_link.h=
:

Should we sync the documentation in if_link.h with
Documentation/ABI/testing/sysfs-class-net-statistics?

--=20
Regards
Yafang

