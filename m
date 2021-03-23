Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6588C34541A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 01:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCWAsH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 20:48:07 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35750 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhCWAsB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 20:48:01 -0400
Received: by mail-pg1-f181.google.com with SMTP id v3so10016453pgq.2;
        Mon, 22 Mar 2021 17:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=XTM6XrWedMr0NF6MUyg1Toqy65ESDtfsApHnZheoawFKScdkRs2KfZNIKUJQzOYqTb
         LrS+Pan6LyCQSM2+/pV1mpWNdbtr4/sAO5K4zm3FJu58UOzLW8kK7t/vqVPXNxIxj0Dw
         hwHNptSQr447DGJD1dPxy9DZAJCm7egfoEoGzzu3NSgGL8HC3BIAs5QLK+GXgyvetkUE
         873fsNI2aJ42HfpBjgVVGz4y9x074u2Ufilam9czvNXziiXK7gFJbAg53OdKLe72lU+B
         opmKlYjSHeE0jyL/yNl6IStZOhN6/KS7ihkby5eF1ivVqZbC4c0v02mzwkATAUv8N5fP
         Vnbw==
X-Gm-Message-State: AOAM5311uN8fKyfCwCp57DDdp9qcr+urrN00RXCu/dKzBpypehK8UyY+
        FKz/r2wKmRfiXBEpUb+AzhK+AL952fA=
X-Google-Smtp-Source: ABdhPJwfDHQHdX4AOnxQt4dcTsdZpNBLmmWNMk5MPKdBEmkXlUf/CHYbnLmdhG3mCCzCHRuk+2jlOA==
X-Received: by 2002:a65:5543:: with SMTP id t3mr1774498pgr.275.1616460480451;
        Mon, 22 Mar 2021 17:48:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2a1:40ef:41b6:3cf0? ([2601:647:4802:9070:2a1:40ef:41b6:3cf0])
        by smtp.gmail.com with ESMTPSA id p11sm508297pjo.48.2021.03.22.17.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 17:47:59 -0700 (PDT)
Subject: Re: [PATCH v2] infiniband: Fix a use after free in
 isert_connect_request
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210322161325.7491-1-lyl2019@mail.ustc.edu.cn>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <99aa5608-08a3-ce5b-8515-5091b3c9fe79@grimberg.me>
Date:   Mon, 22 Mar 2021 17:47:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210322161325.7491-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Acked-by: Sagi Grimberg <sagi@grimberg.me>
