Return-Path: <linux-rdma+bounces-6618-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD59F5F37
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2024 08:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7342188BDAF
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2024 07:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7CC1586DB;
	Wed, 18 Dec 2024 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="l4icr73f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E29156991;
	Wed, 18 Dec 2024 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734506647; cv=none; b=ZK4q9i8sm/eV84UrI0tqJjX1lTdmL/bDqndXtWb936gp/uUa+JfQhWNrekqEmkWTtWLSuoEPGvmEYGicRyhou3H7peeVnIPHu6wgfOMgFORJgjtBIYew8ZSw+rc2GG+kY0aRlzJZxY3vH/KIyIgKWWuCTWkSyua7DWTOqGkucJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734506647; c=relaxed/simple;
	bh=6V0rDVjgmJnBHhAArWaWHQLHma6y/r8IY9FraCqw5g4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cCaLtnLMOHwL4sub/MP7/J7jPH4NmGRukeMxT7QZr1b1lrzMQJ20cMN/z/NOnP88MsBE3PSoG/36pATBEgqvy7iH5sHrJRALTvaDkgG/fJOQ518IBJ063EgdmJ3S3AeckY8qe1ABIPFyzF56YM58PvTvWIbQOzOB5LGLbvj8Q74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=l4icr73f; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734506608; x=1735111408; i=markus.elfring@web.de;
	bh=6V0rDVjgmJnBHhAArWaWHQLHma6y/r8IY9FraCqw5g4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l4icr73fCGnxOOSjf2O81aSnRQfHjO+PSEp+P/t+caoqe9GRwmjwU/Z03LpKMmMC
	 sn5ezmZvxbO99MDCgSDJmpGQZaGZlsyuz1pIUizwQmg0zannQRJPXCLifuwHh7qcJ
	 XIqV/W8jp5Rkr0CHTbmERKHubSNtOvpWwRZjcRz0bfcHPOULGAWhZEum2lhYZGpqy
	 Zq74qw0WTtfKvUVYj5vAch+jV2yjwfOKjz1hKnzeAh0GQadh44AA7IzVhKUqtk4od
	 WfKfIfc0Ln9Lw0YruA3uHBlSyeCQPyqJWfDC/qSn2ArN+nOyu/NaXOFbxkaifu2h3
	 xzkMJuU5J2zj0BgIqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.70.41]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWoU-1t8Kr21npo-00KDYE; Wed, 18
 Dec 2024 08:23:28 +0100
Message-ID: <d1bef6b0-9d5c-4e0a-b758-f22b3553f005@web.de>
Date: Wed, 18 Dec 2024 08:23:27 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make_ruc2021@163.com, linux-rdma@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241218023614.2968024-1-make_ruc2021@163.com>
Subject: Re: [PATCH v3] RDMA/srp: Fix error handling in srp_add_port()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241218023614.2968024-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lu/YVsaWe7s/Yc72SEZ7Uneoz7pW7OiG+GDZ2iui0xhvdM+Z4U/
 1/AlUH5zXhC/UpOnpPivVSArZnVm+2tls+u9nL+I90HU1Fc3s0CQLy7+IMBsLc6G3i7HhFg
 U/OOSfR5z5jV/WzewOo9rZqcNltsR3CAfEqQHoFKFHf9sYfIy3XeAzOMCbhhc8aNZ2GzGUv
 M1PtSDcT58FEbJPd6QYbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ckHRDyMkDZo=;RxuW3uCv3Ru0SVZtyUfNss08hTS
 wxRcfM1malKnMIROonEJWwd48jZNbpTm2/E3se4pnRxN+5FfVQrNyaOeaHzO6JN/HVLduQ2yx
 QloAgGSMW/uPwhpPN7eRBriDqgpXG+bfyS2aWFooH2BoeKmvMgZ/+vPPysw3T0tE0jIMYX4OQ
 V1CPlvBorQCap0wxIWz0ed7rQWtoAf3WuY9cWOAqV5Qc/wmm13TKYSO+M1NM8F5qpkAkeTBwM
 mlxpJhcgiBeuj06A9BgeODN7/QsC+SQA4M2idB1Oe4oXtKW9jZVjxeDp/HCoTzyP/xTuZVP03
 JZn26Qh4asBZljLQUjMUHz4wTtiCZijjryvDbGb0uKGw5w26avPGNuzHVHq7SbzOYzBVz7HM+
 uHXxiirBScx1ytlGVZQ+zbuZseTccXVoZnanv1g5i9hqRg8BoWDL7CDnbMMBckf+2KzNDC4W1
 I3xmz1Cin3hch3SZL5gubthtLGcAV7T07O9HrjF1M2hzN7Wnw5xM6N/ITI9yD7n1aQecPXLlu
 IRBH0TxzsMboWVUt+M+SNa6vSatNYAlWYErgc7Y6DfKI/vCqy9+3xE75clxP4yxaShDUW09mI
 ERLj4uHbFBQ7pCzfOenN5s3SujfHyCr/bfuGc+Fvom82wAmDU2OFB6XGy1LB5K1kl+BPen0Dz
 S9Kz2dbCaLxHmRJgbzi8whEjbGGxfuVNBRHLm17AIcbkfkKM5PnWgrxNUybqLwUVcnvxHse0X
 g2DdyQDweC2E3FdrVJvIc6vzvUm3wvvvYIanNtT1jF0bt6RbWGQFvxiDdEdqcpYPY7fAh0gmt
 lclpZ/BegzqCD9QoIHB2/MQ3DAAkqqat0dqeg0CXnimYOo1VfOIxzsdxkVeke2UHYLBn1Fzuy
 0fr4diuCnm6jkZdqOZEfkp9mTEpJ1YIK6MDJMBmV3amzEWNVtkhj2q2FjrtT7uCDWnChOtg3z
 55WsmhknxUaTifFa6KDvBHoMhhAw8th6W15WMsSOtvbasJC2EpaqhSLWeV5k38onmGD5swC/C
 dsndElTYyV5T5CXNSKQIJuA0lq9UBsO/M7nEPE0hStETNLsMjVxn2WBgWWd9K5sOglgfo/CDZ
 EIvrTZAqQ=

> If device_add() fails, call only put_device() to decrement reference
> count for cleanup. Do not call device_del() before put_device().
=E2=80=A6
> Found by code review.

Are you looking for possibilities to improve automated source code analyse=
s accordingly?

Regards,
Markus

