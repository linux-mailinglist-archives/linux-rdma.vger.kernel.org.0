Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54AFC110224
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 17:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfLCQZE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Dec 2019 11:25:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34307 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfLCQZE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Dec 2019 11:25:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id n13so2109662pff.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2019 08:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s2ZJ52Lp3moeubwpd5H4H9JV30W8DY/jyWt/3XYBZxU=;
        b=AMuJ7NHwLzHLKalCxxfNSOD1tb2ufUCtxb8No42CGheMOHwnYODriPV2b8oIc80Xd4
         yzqQJxBdWx1wo75R9iJ/4kimCaycNS2eeLkiucuhwqtim8iz7TAYBmyD7m62j013Ba1o
         C1ufanKOr+5ZUGTmS2UcUCwI0K4k9IqMSisSgEYttHztfUCXxzqsPf+KYExmYr3w/HK0
         yksqSGRjACBYPxbNVeSp/pOQMxRkC7cxv5K/WJ0CLRfETZ7kyl85ug0ZRW7mj8psR6CK
         uk1NaPyNtQ5v7oza6B+kdQ2K8F3ehooO7suiMIfvR+M1gJ92dIQZcqd95eUO/cv5fKGY
         ywOw==
X-Gm-Message-State: APjAAAUw6qSohMYkYZuxmJ3kqsKbLp7/U1MtBdJ0WYdVp8aPcpgo9+SU
        YgN0Vq1JIoHuDNLMPwQs4aM=
X-Google-Smtp-Source: APXvYqzJyQSUQ0RVk50h9Foo0dWFP4Mz1bcAgbmH/aRHZyodAsG5huid4vNNyk3WX639Ktjc8PlgUQ==
X-Received: by 2002:a63:710:: with SMTP id 16mr6238626pgh.58.1575390303338;
        Tue, 03 Dec 2019 08:25:03 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u26sm4121043pfn.46.2019.12.03.08.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 08:25:02 -0800 (PST)
Subject: Re: [PATCH 2/2] rxe: correctly calculate iCRC for unaligned payloads
To:     Steve Wise <larrystevenwise@gmail.com>, linux-rdma@vger.kernel.org,
        3100102071@zju.edu.cn, leon@kernel.org
References: <20191203020319.15036-1-larrystevenwise@gmail.com>
 <20191203020319.15036-2-larrystevenwise@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a0003c88-10f5-c14a-220d-c100fa160163@acm.org>
Date:   Tue, 3 Dec 2019 08:25:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191203020319.15036-2-larrystevenwise@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/2/19 6:03 PM, Steve Wise wrote:
> If RoCE PDUs being sent or received contain pad bytes, then the iCRC
> is miscalculated resulting PDUs being emitted by RXE with an incorrect
> iCRC, as well as ingress PDUs being dropped due to erroneously detecting
> a bad iCRC in the PDU.  The fix is to include the pad bytes, if any,
> in iCRC computations.

Should this description mention that this patch breaks compatibility 
with SoftRoCE drivers that do not include this fix? Do we need a kernel 
module parameter that allows to select either the old or the new behavior?

> CC: bvanassche@acm.org,3100102071@zju.edu.cn,leon@kernel.org

Should this Cc-line perhaps be converted into three Cc-lines?

Otherwise this patch looks fine to me.

Thanks,

Bart.
