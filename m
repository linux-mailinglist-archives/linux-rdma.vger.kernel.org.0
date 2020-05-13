Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BFC1D0415
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 02:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbgEMA43 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 20:56:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40376 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731683AbgEMA43 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 20:56:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id x2so7229085pfx.7
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 17:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3NNZmBzbA5W8qkCUtwpAyc0bsZckfx0rZIzf6SPs+KI=;
        b=hNoPkvHJoLIjfNPjsu8CLe3h6ng1nunvK3C1vsXXjctsq6aVnecQWHQsfFjQFczQav
         ClvtY8n1SsGLMawKnPVBGwAh5Qyd+qLVqGyRiO0evBcvPUKDCmaAQxJcfGhSd6/a79+j
         Ph5AVCP1+JSqU3/B4ROfSUt6UQhgKBnQ4zYz9QUm/I3PQ+IBp0wgFLjPWsp03vz/bpqB
         nzhJv+hB5Ursp2lBPIPpVHtOlSFqhqYk9aNcMv7Kvooao3r62wF9ZdiOI4KRjpP/4mnV
         Jw4I+48oozWteJBK56MZG0IK1OYpgjLsDTbpAg+VPij8k7WEj9Yl+ECyD4iNGtaMlV26
         8zKQ==
X-Gm-Message-State: AGi0PubYzC5eyOVKN/7KrwDk7sTjzOhdyUzHAeD9Cq6jLiuQplHey1GE
        YzvqKy0Fsx9VL48KOUjfADM=
X-Google-Smtp-Source: APiQypJRhGl0sOI7imjGm8F0ezB6ElinpBO68TIiRuqxPWG0CBqdNxTkRBQxp3qVqx15DNqOzbNjvQ==
X-Received: by 2002:a63:e202:: with SMTP id q2mr20677151pgh.323.1589331388283;
        Tue, 12 May 2020 17:56:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fd29:b320:9d75:d158? ([2601:647:4802:9070:fd29:b320:9d75:d158])
        by smtp.gmail.com with ESMTPSA id 3sm13166683pfo.27.2020.05.12.17.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 17:56:27 -0700 (PDT)
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
To:     Israel Rukshin <israelr@mellanox.com>, jgg@mellanox.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org
Cc:     maxg@mellanox.com, sergeygo@mellanox.com
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6c20dd16-d5c9-b33b-1692-93f3a4f3bd52@grimberg.me>
Date:   Tue, 12 May 2020 17:56:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks Max,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
