Return-Path: <linux-rdma+bounces-11063-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43FAD14C6
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Jun 2025 23:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26223A8BB7
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Jun 2025 21:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC94211A00;
	Sun,  8 Jun 2025 21:34:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF331E0E14
	for <linux-rdma@vger.kernel.org>; Sun,  8 Jun 2025 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418469; cv=none; b=XATrzFk3anPHIPdxcQoblT2mxvwDfMRg1eZv7XmqmdaytN3FnKTqDbgvGKt+0CZRm85bMVKBGg0aqV/uFUWaTa4psM5DJ/Pk0WEsM8/BnkSN0YvQXIG9FVkP6klwL/j5R+Yiulm+m/9HdSlHW56z+x9QkQO1RbX1w+PqKQuq9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418469; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d/DFU7FFhG+5dNZKN8mr5o1BdqUt78O44YqUaTCfeqVnmQnxTFLWTEB91UK+gH0QYTvFTSvzBMp8KXOgLcMygPetV/P5t/d14IK2NOMQy1/jpjFGEXUdWYZi53Y0US0mJsbKLGXJoZ1WaaFzHGFwHNNIWTaCRi1pcJ9SLufVGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a54700a46eso337990f8f.1
        for <linux-rdma@vger.kernel.org>; Sun, 08 Jun 2025 14:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749418466; x=1750023266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kLjlhI9VFH81AVbWx7uQGxgrlEFkn2PR+mA53L1OazogW2Vko7MjcwYQB8TBoF5k32
         RJk/mak2n2iuI1m2qpaLd65jJ9yD9SNiYYQe98yFu9WkHLTIZb+PNOuAuKdVmAWhWtt2
         MzqagKv0xxI5FBiyY4vRjldIIHgRHdCuP78QekxLPRIthXpp9jlQ3S+8xHLku6UZi4cz
         DoS48g0Xm0sP3nlxDEgxSqkkIrikLhsqT1iwk6+XfpyZmJzyov6G6RQPu6fn0RZC4fM3
         uijhnUyZXTN+uRV3/8dTNRHpcH+Ss8HBavV3JImSUl4IJG0FgSKDzJpf+UNVUPjHTs1x
         GIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKA5HfvbPYls55gEXC5WJg5cBo6UJEU2JBPVbHmxCo09mKcud3LfhRQFTWQ8qMtN0S+ylauJrJpgtU@vger.kernel.org
X-Gm-Message-State: AOJu0YxG66SNXvILURmBWq8VWsU37iqEgpIwApjLrcmYzB7H0vUM2WBV
	olC2UkBc34SIBfutdu8TkQVL7i8k9ZPFprRXqvaIB0yV2JIXbhmRbCJq
X-Gm-Gg: ASbGncvfh8PigiXbc/qyf2NY3DiC+b+WPuzYm4Md7S35HXzUwM1ZQfFr/tztQKvye4e
	Yaxjw3aCdN5DgZqZdQ+D7zc57ueRLZ2xbfL7iK12EwUnREn4Mho3g2K4zjAz+FsWiCNdFWNEMRU
	XE6bdkjUhJx82MK3VMHFDJ26y3dh7YYGDaqRnzPxUrNtGnOMHOY3BxMRYdr+OtyUpJ1ln1+L/0Q
	Rd/DzLWB6eERcjEpNTqrB8j1kpsoaiYki3avH7URQLATH6Sxi9NoifJy5KYuD059zyyOARfYbGs
	ru/mNpvGjivhpJgx47sHyNewDWm6hRAM4matCgemaTZ0xI7DPNWqTJ295Uv/EA1gXpGNDJv5JgI
	NW2+LPnxvgy4bTSdKLzo=
X-Google-Smtp-Source: AGHT+IFQ7LrQQhs0Mfh2A8NNn2zoasRikazjODgnwUoC3pc0Gs/NCRbJPIfq344ZAHBzR6B5yWN5wQ==
X-Received: by 2002:a5d:58f9:0:b0:3a5:3b03:3bc6 with SMTP id ffacd0b85a97d-3a53b033bd0mr3988155f8f.28.1749418465646;
        Sun, 08 Jun 2025 14:34:25 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45306b01d77sm45721265e9.31.2025.06.08.14.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 14:34:25 -0700 (PDT)
Message-ID: <4ffc247d-a59c-43dc-8ea0-84b85f0e1045@grimberg.me>
Date: Mon, 9 Jun 2025 00:34:23 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] IB/iser: remove unnecessary local variable
To: Li Jun <lijun01@kylinos.cn>, mgurtovoy@nvidia.com, jgg@ziepe.ca,
 leon@kernel.org, linux-rdma@vger.kernel.org
References: <20250604102049.130039-1-lijun01@kylinos.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250604102049.130039-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

