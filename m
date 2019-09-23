Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 241CEBBE3A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 00:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391156AbfIWWCf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 18:02:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33200 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389997AbfIWWCf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 18:02:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so205967wme.0
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 15:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=QCjStpEVptZPXZrj+Xsx30VpVoePiqjiR4VHtOffKkOn9iplATRNhQNHH325bmMwbs
         ZJm/RgGpuS0U8MIY7gq6sEiSk46bgu9YJMgwzXDlAhl6KvUizt33OJSglvctxH+kZjXe
         X0GXlzBmwCyU5t1jnNE1Zg4RV3N2pAl7IPUhkNpGVEDdiqueqJVu4bReZixfBhX29E/5
         w+1Atu3cz0YLJyZUsmLtvcCb7RgX/5f2FGdGhBQw6fk2qZrklLZKTUaNpHCg9523RrM7
         k7ahHbbTumjQVZbk4QyenRkUlADUNJ0c+X0UiOLRh6Pf79Mn5AudVg+7r4JOurjQkSnC
         Vhvg==
X-Gm-Message-State: APjAAAXZLDTjsrJ7WJnTfw2WzYxrzFYDttXrixk0y8oVt1e3XqOVyPOQ
        FVcIyu3B/di0dqAnQgRUoKPoQ8YK
X-Google-Smtp-Source: APXvYqwcFylmUK2LyPcnmNA5W6DlrGKg9wg42QfwPFI0lu1ljs0PRf9htQwXY/zenVVTrEKiSjSsdg==
X-Received: by 2002:a05:600c:291c:: with SMTP id i28mr1182681wmd.98.1569276153317;
        Mon, 23 Sep 2019 15:02:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id q19sm18563549wra.89.2019.09.23.15.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 15:02:32 -0700 (PDT)
Subject: Re: [PATCH 1/1] IB/iser: add unlikely checks in the fast path
To:     Max Gurtovoy <maxg@mellanox.com>, jgg@mellanox.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com,
        leonro@mellanox.com
References: <1569274369-29217-1-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6bc9999b-887a-6677-0b32-28a39a10a43b@grimberg.me>
Date:   Mon, 23 Sep 2019 15:02:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569274369-29217-1-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Acked-by: Sagi Grimberg <sagi@grimberg.me>
