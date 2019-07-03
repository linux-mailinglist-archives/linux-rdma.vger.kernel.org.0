Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED8775EDF6
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 22:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfGCU4f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 16:56:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43567 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGCU4f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 16:56:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id q10so3804365otk.10
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2019 13:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=qqHMQjwYpU91nuoWpSVSbs2tKmdgc+25hdDPmT6bRlWj8RyrKghMDC6UPoe7FDIa6N
         b9FPVGLryabTnpqCaqPsWwBJ3L4XjcgukpYuWbKVJ2oVlsRbcjIoJTZ0O/leu7qVgbmB
         FRaoCxr3wPbxPBdgWkaczJxq67GJKu2dt/we7hjdJg4cliu+5VDYBeZ85cKqss1LJJt7
         Blbqti8w+3EfRElLGEYhDw48NVKHU2LxrLG56MtQPxFvENXTuDuBMoC0yynTolmIAg1Y
         Q2MbHMzfI4E5KEmpjj9fo/AeWCMJzh04zk/3i1JWAnXWYpj8i/1UmyMWCECytfDVL8uy
         PR/w==
X-Gm-Message-State: APjAAAWQUhIkAIRnYoFEDeufsW/JuJcwG7QcRUGKBrK5hvteOOIXkNWu
        xocw8sQhsa0mwQPqP0OBenI=
X-Google-Smtp-Source: APXvYqzhtAgC0oEoqnIhFWblUCluBmTfhULgxwlkA5+bONs7CyIVNHsGyoPOUWZnEXomi7gTiPb90Q==
X-Received: by 2002:a9d:66cd:: with SMTP id t13mr31750189otm.83.1562187394781;
        Wed, 03 Jul 2019 13:56:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id d200sm1214112oih.26.2019.07.03.13.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 13:56:34 -0700 (PDT)
Subject: Re: [PATCH rdma-next v3 3/3] RDMA/nldev: Added configuration of RDMA
 dynamic interrupt moderation to netlink
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>
References: <20190630091057.11507-1-leon@kernel.org>
 <20190630091057.11507-4-leon@kernel.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ded0fd6c-38ba-26b0-7c35-d2d99f18e0a0@grimberg.me>
Date:   Wed, 3 Jul 2019 13:56:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190630091057.11507-4-leon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
