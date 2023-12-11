Return-Path: <linux-rdma+bounces-341-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9990E80BEDC
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 03:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4331F20F35
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 02:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57AC11715;
	Mon, 11 Dec 2023 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8OYkgnx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A147493;
	Mon, 11 Dec 2023 02:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9ADC433C7;
	Mon, 11 Dec 2023 02:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702260090;
	bh=jNSwzknoPauzDQfALDkugaQk0L0XrriktF5PQv3qJTI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=g8OYkgnxRC3Ynmj9xuWwAMyr5mGT5l9oBFQPg7X5sXv3nBPXp6Juzk127wUAitbhz
	 RJPn3dnIoNdc5koJitCn1I69hoR+chvdcj/ooxloSoEpf8bFC5xiLmmAYYQjVFk94w
	 nZd/kqE7TtWXPUER1QhDHpn5jqKSBFUjw+uX+0r/hYewyk67gptqy8BoI6ToKHPjhu
	 S6SwgsvNnZ49DAAB9Qpp7rpFqIlr19jIyBEQCE+kJrWMSTZTgRz8NNLzIQ9hjt4Mga
	 Ig+kzw/cL1vKbgB5UFfcQhCSvxcIPQxGXCxLTU45KSEpWwZ8Vn+b1piMmLgJu+mazY
	 3zT0hScUOIN6Q==
Message-ID: <8308644f-c56a-4c8a-906a-4aaa02c942d8@kernel.org>
Date: Sun, 10 Dec 2023 19:01:29 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v6 3/7] RDMA/rxe: Register IP mcast address
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
 yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 rain.1986.08.12@gmail.com
References: <20231207192907.10113-1-rpearsonhpe@gmail.com>
 <20231207192907.10113-4-rpearsonhpe@gmail.com>
 <7e370f63-f256-45f3-89c9-7774877afaba@kernel.org>
 <baadce1c-7fd7-4756-9d4a-4a79483e576e@gmail.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <baadce1c-7fd7-4756-9d4a-4a79483e576e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/23 5:56 PM, Bob Pearson wrote:
> Thanks for looking at this. What is the in kernel setsock api? I'll give
> it a try but I am not sure what to call.
> 

do_sock_setsockopt is what io_uring uses. Start with it.

