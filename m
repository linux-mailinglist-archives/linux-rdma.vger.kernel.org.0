Return-Path: <linux-rdma+bounces-9473-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B522BA8B303
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 10:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3841F3AD6FD
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FD422FE06;
	Wed, 16 Apr 2025 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="a4k/I7Nx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA6E22F16C
	for <linux-rdma@vger.kernel.org>; Wed, 16 Apr 2025 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791156; cv=none; b=Ro4oRBLPXumrR7Ym34da0YV3/xn3Ay/IxdTS6fxavQTw0A9dvAi+1/Ht4fdO2XJgnaa4XPYfoLnz6A7sYXJvakaarBPEICn62lIGPkE9x+zupVpATD7jJl3+jwL05sY0qRzGOKOVURXVmZ///uawIywGvBDKE2msbTOH/Rj4xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791156; c=relaxed/simple;
	bh=UqpYDKEGBNrCP4IDpHxnNSRgmJd86ZMFLlHPoSsuwB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRO+4Hk3N5j92z2mR9sENmkm5BGAW1erw99vVXT9HrUjEa7Zftkw7XrI89jvfKHgPn0sn91Bf3MWCda1njNs7PPqjoUVQk2nrxsrYwXfLxkzB5ieexxMjEcNS2ba8XNUDb/aU020WLULHWBCJpQcxBJpiqLX6o6KcWK41//zPUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=a4k/I7Nx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso8373779f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 16 Apr 2025 01:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744791152; x=1745395952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/4bHaraL4n/P0iTE+QqqFajLDyDWyG2jsQgWhbDjMQ=;
        b=a4k/I7NxfE+MLqX6uttNSUyfNND1IYa04gaTanD+jFTxoEmHv1Pny+Kk8nnpZwJuFw
         wfYL0AIECiNy0eiv4FiYtI/a36+rwPoIV/n1iQco6OH8YbpXkdcB/7Kgiv6lePpvb7Qv
         IkhEEMDfgT8+3/MquUa/UR8RgyrBLKhoV6XOil5C7lWa9MqOAthzBKNZONwtY+RW12wz
         47P8ZGGy+BSY1Pl1LSkvdGkRe0ssXeFm4keYjgCQfGf6QDsJJSWS4tY6oLhwSGUdu9NZ
         XPAnpqsFsy1pd2uxdamq9FkT/XfDqtUIOiAgbkjEgdUxG+AQBlyE1ww+Azfi21Rx9oD1
         xQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744791152; x=1745395952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/4bHaraL4n/P0iTE+QqqFajLDyDWyG2jsQgWhbDjMQ=;
        b=GSURIK5YgKr/sOGzsL/IfkbYKKWjKeGRT5adPxswlLABZKXpdu2M03YLwYoTkc5KR9
         TocNl3Bz3J8DFU/2jmndI+7gCz5SUjdtIQRlU1HAhSDw/6PwCzJ/IwTiBT5/AKqDN39w
         3GfUTdeqTomJFXlynCvw5E7FR9kpjm3hntBA5iU2WCf/CbFyZh729jELMFRPEmxvO4eI
         27ohejYBA6ScJCxnBtKKYC13SCin5k9keuinLvLpChW2WBkJCeCukRsAd8l+kD/ib4qB
         AszSvLiJ9klLwTDHmf55rzcsEczor0s/rEHK25DHx2FFtRBKTv3GY7OZA3bD+Y2r99wy
         Nkcw==
X-Forwarded-Encrypted: i=1; AJvYcCXsVi91hnBB0Lv/2tg+l3ra7du7z5OZ7mfCD4mXp7cUDfHCaeLShGnA4ctzsPLL3mztJbN39H1OdI0N@vger.kernel.org
X-Gm-Message-State: AOJu0YxCNB1cd3cMTHlbM57wQeRiKkrzMPKwITH2su22FIuxIamSimqD
	SFH2/szJUpBLMK0jq0vQ2Aq9pyUjSQWLWCqcSv3STI8tcQwW8n2VKvi7R+g2vWM=
X-Gm-Gg: ASbGncuiQdr/b+X/mq2bWx7rZJGjLiNCg4TiD57EykrUrWxg167MhwKqTWWCcsuhH5B
	CY3BP3SW/ycU21pm5qZR+oHLt+QYl5rgwMgMpxmo5mDKhLmtRncorPHmh1NgBlWiYJMkm6a0ADA
	VHspTRTeQ7TXLxdOlpRsdqcloYEcKSH75ZP4QuY+owB9zaMa3OtHqPJZ4iLjbPKPkeQGwEEi7O7
	89GxHMTBbXBu28tUZ2SkCvHOR7xLdyEfKuSO0MOHehT3aYESla3zK56ztbU7cONi9ZJtFOqIcE6
	2llnCxuC+buM5r3ZTqrtvk3cXv3cIQ6wIv1ThN9ueSNiKWzhKu4Llw==
X-Google-Smtp-Source: AGHT+IGxaQcIkGTI0aBQCrdg5Mdz1bajPY1DljdFhlFnwzhWRIuUx+MIrx6GZMLHMpwt9t1FLRkhxA==
X-Received: by 2002:a05:6000:18a7:b0:39c:2c38:4599 with SMTP id ffacd0b85a97d-39ee5b9ee51mr819435f8f.48.1744791151941;
        Wed, 16 Apr 2025 01:12:31 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ee6010449sm515446f8f.9.2025.04.16.01.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:12:31 -0700 (PDT)
Date: Wed, 16 Apr 2025 10:12:21 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, 
	aleksandr.loktionov@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/3] dpll: add ref-sync pins feature
Message-ID: <6ss5qghishcbbbmj6ifitafl6fnbfhnw6crrkitgunays4qtqv@ixvlqemyij6x>
References: <20250415175115.1066641-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415175115.1066641-1-arkadiusz.kubalewski@intel.com>

Tue, Apr 15, 2025 at 07:51:12PM +0200, arkadiusz.kubalewski@intel.com wrote:
>Allow to bind two pins and become a single source of clock signal, where
>first of the pins is carring the base frequency and second provides SYNC
>pulses.

This is not enough. Could you please provide more details about this.
Motivation is needed. Also, from the examples below looks like you allow
to bind 2 pins, in async way. Would make sense to bind more than 2 pins
together?

Honestly, I don't understand what this is about.


>
>Verify pins bind state/capabilities:
>$ ./tools/net/ynl/pyynl/cli.py \
> --spec Documentation/netlink/specs/dpll.yaml \
> --do pin-get \
> --json '{"id":0}'
>{'board-label': 'CVL-SDP22',
> 'id': 0,
> [...]
> 'reference-sync': [{'id': 1, 'state': 'disconnected'}],
> [...]}
>
>Bind the pins by setting connected state between them:
>$ ./tools/net/ynl/pyynl/cli.py \
> --spec Documentation/netlink/specs/dpll.yaml \
> --do pin-set \
> --json '{"id":0, "reference-sync":{"id":1, "state":"connected"}}'
>
>Verify pins bind state:
>$ ./tools/net/ynl/pyynl/cli.py \
> --spec Documentation/netlink/specs/dpll.yaml \
> --do pin-get \
> --json '{"id":0}'
>{'board-label': 'CVL-SDP22',
> 'id': 0,
> [...]
> 'reference-sync': [{'id': 1, 'state': 'connected'}],
> [...]}
>
>Unbind the pins by setting disconnected state between them:
>$ ./tools/net/ynl/pyynl/cli.py \
> --spec Documentation/netlink/specs/dpll.yaml \
> --do pin-set \
> --json '{"id":0, "reference-sync":{"id":1, "state":"disconnected"}}'
>
>
>Arkadiusz Kubalewski (3):
>  dpll: add reference-sync netlink attribute
>  dpll: add reference sync get/set
>  ice: add ref-sync dpll pins
>
> Documentation/netlink/specs/dpll.yaml         |  19 ++
> drivers/dpll/dpll_core.c                      |  27 +++
> drivers/dpll/dpll_core.h                      |   1 +
> drivers/dpll/dpll_netlink.c                   | 188 ++++++++++++++++--
> drivers/dpll/dpll_nl.c                        |  10 +-
> drivers/dpll/dpll_nl.h                        |   1 +
> .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
> drivers/net/ethernet/intel/ice/ice_dpll.c     | 186 +++++++++++++++++
> include/linux/dpll.h                          |  10 +
> include/uapi/linux/dpll.h                     |   1 +
> 10 files changed, 425 insertions(+), 20 deletions(-)
>
>
>base-commit: 420aabef3ab5fa743afb4d3d391f03ef0e777ca8
>-- 
>2.38.1
>

