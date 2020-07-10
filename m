Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D078B21AE3E
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 06:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgGJEyD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 00:54:03 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:33192 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgGJEyD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jul 2020 00:54:03 -0400
Received: by mail-pl1-f172.google.com with SMTP id 72so1764193ple.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2020 21:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j+6d9twQoxP4/CVLU7nCkHaH3N6KQuauu7v4bZ5Coe0=;
        b=SWfvDtEvL85e8uz/Gqs0qcamFyg+UFA8JSKzJyEW+ZISRuLxJ5M/05Dv5x/S1Qlt1/
         gowUBa1Wdyw9UWX3mxEhr6xKe170jj3NBbIo7N8vhulOHXmWfUKt1FHHXmsXqQAZiLXA
         exQXRlNaKhmwVZ5FdK++JAWRb45lNg+9HFfAD6qR9AdC8Cz67u4GxL8MWERhjAmBC73V
         O6v79YInjl+L8bEhEEjSmtPjeJAOVRf9PyfAF1zvL8ZPehqJcM47o4qP9cYjPM8L9hQH
         gP0RBvpYeOvuzFO1ZRR0KzQ8bQPaHhNyJwEWxlMCgjxbdXv8C97OQCB8oIr5oVIFvo31
         XFew==
X-Gm-Message-State: AOAM531Pz5CKPSgQ8jgRagFgTHtaqIdWR6HecKmMRYrpkT0YMjQDwUGA
        K7hq+3Dqo2MIfYCFy8QP4J/tMWTn
X-Google-Smtp-Source: ABdhPJxoSB1gGkKih1c2FAtBp65Oq5+2Xl5PFFqFJCPj5D132hFWmgm/dwNQfXypyW8KBc+0o27m5Q==
X-Received: by 2002:a17:90a:c290:: with SMTP id f16mr3722498pjt.143.1594356842766;
        Thu, 09 Jul 2020 21:54:02 -0700 (PDT)
Received: from [10.92.82.19] (h208-100-138-50.bendor.dedicated.static.tds.net. [208.100.138.50])
        by smtp.gmail.com with ESMTPSA id u73sm4540168pfc.113.2020.07.09.21.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 21:54:02 -0700 (PDT)
Subject: Re: [PATCH 1/1] IB/isert: allocate RW ctxs according to max IO size
To:     Max Gurtovoy <maxg@mellanox.com>, krishna2@chelsio.com,
        linux-rdma@vger.kernel.org, leonro@mellanox.com, jgg@mellanox.com
Cc:     israelr@mellanox.com, nirranjan@chelsio.com, bharat@chelsio.com,
        oren@mellanox.com
References: <20200708091908.162263-1-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f6e34a3a-6755-2aeb-2128-5bca41cc7852@grimberg.me>
Date:   Thu, 9 Jul 2020 21:54:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708091908.162263-1-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks good to me Max, thanks

Acked-by: Sagi Grimberg <sagi@grimberg.me>
