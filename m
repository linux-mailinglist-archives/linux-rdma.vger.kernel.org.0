Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 772E2BCBA1
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388250AbfIXPg2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 11:36:28 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:43027 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388323AbfIXPg2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Sep 2019 11:36:28 -0400
Received: by mail-pl1-f180.google.com with SMTP id 4so1143494pld.10
        for <linux-rdma@vger.kernel.org>; Tue, 24 Sep 2019 08:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7eyS/MwlDN5AtjKA0OIivf0pVeLOAa7/zaRKOXRwEZ8=;
        b=Pqyrq2UF0aWKumK8VkGj2fo1FAyTOZOqPG6rDE0WQOzC+b0SwDmVa1r0MXi/2FrK8i
         Yc8sbE029zj31gwQMrxKYyGa7EqkwFY9ajfIGAWlaw6py1wpoYmZkcyXVM77Nk1ZFIMe
         LY7tHCIDX6zRWJXysJxUL6nVk0jaIcv89u9L8HysI+VNqPooqDaWTnQPmJ22r6GaDxnw
         3LaNnqzea55wt0IE5ftez7YJuSANTtdVEMmj6uYYb1f2iuIBL9zMmsKE+e9GcDqSC8C+
         1XpKaOI2jNZcXeon/5QJco1i7eOGzzZtpmEZVguwh4yskDi/m6vJYyNG2AbwxsKK1KtN
         PELg==
X-Gm-Message-State: APjAAAX8kbrNUdMBfv9cIkicf0tPmAk1MR7WKU6Cx6tb9BXH1sHopNw4
        NO84LTnaADpQsYSUrWev67l5ZXRS
X-Google-Smtp-Source: APXvYqzHoV+SXGnAIJ8yuDTpSe2kftVeHay5o8q3uup2ya6chGn1GWvN8QPzYDPPBUqRLYBDkfOVgQ==
X-Received: by 2002:a17:902:7282:: with SMTP id d2mr3594327pll.85.1569339386613;
        Tue, 24 Sep 2019 08:36:26 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 69sm2942932pfb.145.2019.09.24.08.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 08:36:25 -0700 (PDT)
Subject: Re: [rdma-core patch] srp_daemon: print maximum initiator to target
 IU size
To:     Honggang LI <honli@redhat.com>
Cc:     linux-rdma@vger.kernel.org
References: <20190916013607.9474-1-honli@redhat.com>
 <deb829a3-813e-6b99-c932-ceecc06e09b3@acm.org>
 <20190918005508.GA8676@dhcp-128-227.nay.redhat.com>
 <46dfd841-f7d3-52fb-6737-253ce95108c2@acm.org>
 <20190924015936.GA28951@dhcp-128-227.nay.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8c3cc0f4-1ddd-6a7b-87ac-f79cb5487385@acm.org>
Date:   Tue, 24 Sep 2019 08:36:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924015936.GA28951@dhcp-128-227.nay.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/23/19 6:59 PM, Honggang LI wrote:
> If you want to use "Maximum size of Send Messages in bytes",
> just let me know, I will send a new patch to use that.

I think that description is short and easy to read.

Thanks,

Bart.
