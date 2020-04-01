Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B7919A50A
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2020 08:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbgDAGCh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Apr 2020 02:02:37 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55366 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgDAGCh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Apr 2020 02:02:37 -0400
Received: by mail-pj1-f67.google.com with SMTP id fh8so2230767pjb.5
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2020 23:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=nvcfWhIXqBYO4SslzyQp1Rb1fqvy5ZQBekVSsmvRh0+TzEqiAIVrZcDI8gXIMaAk3a
         swo/UNynQlELTiYuO4POylVTGbd85A9kk2f6Lq3Tzf0yaeL4CAWM13Hi1Ja4fQBRYbWY
         poWZx7h1X9GzyAQyvULY46HuyUnGr9m89LmUeRrTnj4PSBgvxf3hEMsoYN8fY33t8i5I
         9zXoqn/eKoPnj7N7wn7zUCV3jZC0i3zCHvqpnfFzti/FGeQ2uJyiPai8BoxXjvLbVWRE
         C7/FkcJ/W7ueEaHV7Y/gyWBCi8tWALObsbyYic5gyzLMbIHZ2RuaX+RCri3VWW8dl6X7
         5Ohw==
X-Gm-Message-State: AGi0PuaZAeqaPvkuXTt/lxmvKad6EPaBAn5JkBMIipxyd5wbw24K9Rgi
        t1tP2QpbYp7tbNXh3csQ6Xz/Byhy
X-Google-Smtp-Source: APiQypIj1DzrPRlAx+O3t6cxMF7VI5IbDRqskNeVl5g9vmSOaaIzgL8rT8PTpUN1tvYqxaOpqeisXQ==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr2843642pjb.79.1585720954502;
        Tue, 31 Mar 2020 23:02:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cca1:4ce7:5ea6:1461? ([2601:647:4802:9070:cca1:4ce7:5ea6:1461])
        by smtp.gmail.com with ESMTPSA id o15sm703216pjp.41.2020.03.31.23.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2020 23:02:33 -0700 (PDT)
Subject: Re: [PATCH] IB/iser: Always check sig MR before putting it to the
 free pool
To:     Sergey Gorenko <sergeygo@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>
References: <20200325151210.1548-1-sergeygo@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <351df07d-b7e9-2de9-e74f-f8ee6ff6a465@grimberg.me>
Date:   Tue, 31 Mar 2020 23:02:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200325151210.1548-1-sergeygo@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
