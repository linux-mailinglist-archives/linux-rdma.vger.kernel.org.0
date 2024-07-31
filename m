Return-Path: <linux-rdma+bounces-4136-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0FE943179
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 15:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52608B21070
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97761B29C8;
	Wed, 31 Jul 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="FrInM/QO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1621A8BEB;
	Wed, 31 Jul 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434220; cv=none; b=nnHBIdzi19VLd8uyTH6UP26CWcAoU0wWGWxvmnoFCY4XQfIUNSmQK1KWoAjO0hUUEEJ30EjPcIDNMPYfbGSwLNo0qO7QkdjGDW7ZCWcvv68oku6d5qcPvZzUUrgpSu1S/OQELDurExRIBnmyuIGyz79MRSye/ezvJmXMLfBzcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434220; c=relaxed/simple;
	bh=eZEX4rdn9mBPxRIbIA/pkx7LXyDI7S1/wvrYsFh9fsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fL474cbB0aBhYXx4OncQzSIF1Gu2WY6OKVOZHFx20xbG04hHZHDRhjT01Lmf1+w21AU75PnS7idLMQM6uggycP2UIU8N0zzx5iwu0nzF+FzyHokwvolH5Xx3GOclmtU6Z91X5weBwkSV+c+lhOkCDzlW+xhB2qFVipfxBpTgEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=FrInM/QO; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 46VDuBRI018780
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 31 Jul 2024 15:56:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1722434178; bh=1Ux9xRhFIe5oDy1kcoI5B9Woeq+41Bja85eiI4B42Kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FrInM/QOjdiokSfBYJJgK5VEq2zquDVGEPAkbsZHyQC8+Uvk+bUGKEluXinNVgXl5
	 bwfK3TeiTWharIfR5DBeHexANiGs2YSUvFKobJsMuCJ6LGvnLAV0MKJ4IsfpuYuaZY
	 Q/ZggpxqufDFdgJ9yKjzI9QeY8NQPwP8j7s8Vksg=
Message-ID: <e5c0ba6f-0da2-4f77-bbcb-0aa3dd736859@ans.pl>
Date: Wed, 31 Jul 2024 06:56:10 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net/mlx4: Add support for EEPROM high pages
 query for QSFP/QSFP+/QSFP28
To: Ido Schimmel <idosch@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org, Dan Merillat <git@dan.merillat.org>,
        Moshe Shemesh <moshe@nvidia.com>, Michal Kubecek <mkubecek@suse.cz>,
        Andrew Lunn <andrew@lunn.ch>
References: <b17c5336-6dc3-41f2-afa6-f9e79231f224@ans.pl>
 <Zqn5sNLbg9pMD5LP@shredder.mtl.com>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <Zqn5sNLbg9pMD5LP@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31.07.2024 at 01:45, Ido Schimmel wrote:
> On Tue, Jul 30, 2024 at 05:49:53PM -0700, Krzysztof Olędzki wrote:
>> Enable reading additional EEPROM information from high pages such as
>> thresholds and alarms on QSFP/QSFP+/QSFP28 modules.
>>
>> "This is similar to commit a708fb7b1f8d ("net/mlx5e: ethtool, Add
>   ^ Nit: s/^\"//

Ouch, do you want me to resend or it can be fixed when applying?

Krzysztof


