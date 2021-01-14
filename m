Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF1B2F56B8
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 02:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbhANBwO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 20:52:14 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:33315 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbhANAI3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jan 2021 19:08:29 -0500
Received: by mail-ed1-f48.google.com with SMTP id g21so3889454edy.0
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jan 2021 16:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fnr1WWxKjiH+aXhJoCQtrSTPD+Cjz7a036JXcIlxY/Z428j9pQ/u7tym9o1W1Dpw+1
         jTYTAFob8xLn+aRaSAP2hsFlU3pwXdU3a5W15NjFywgP5RbLGtzhH3xoh5/2NSD6lFyf
         pJ+1xwuKjTCLKLrfzN4mD/pGMms30hb/8t90YS9nc8/dFuQFdmOKuDgMNyOVXqaVgdRj
         KECpcqrl/sXkyCBoSiidLunWIcM3sWlRVqyI5sNFCwguHiGBzGY2DUUikxahXwLRILkt
         6aqcPZ5oQhn+Bux91vHS9OzB3I0peOnl/bMeFb5kQ8quTxtjReYZAh4I5k7+IFHG0WXy
         qIbQ==
X-Gm-Message-State: AOAM530qPegACm1KpNkF46x41GcEAsfiA0xfXk9P6XKeHaK9g6/1QI1R
        bjYJIP6Foxe0DtS+i5js7O/L5gCC2JQ=
X-Google-Smtp-Source: ABdhPJyJEjAqIj7oGMIJrhovq5806SgBi/7TsrB9i3IpM3U6VWlmya98NKGh5jFmCkdYEGx156Seog==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr4923161wrq.75.1610582442654;
        Wed, 13 Jan 2021 16:00:42 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988? ([2601:647:4802:9070:e70c:620a:4d8a:b988])
        by smtp.gmail.com with ESMTPSA id i18sm6308628wrp.74.2021.01.13.16.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 16:00:42 -0800 (PST)
Subject: Re: [PATCH 1/4] IB/iser: remove unneeded semicolons
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        dledford@redhat.com, jgg@nvidia.com, leonro@nvidia.com
Cc:     oren@nvidia.com, nitzanc@nvidia.com, sergeygo@nvidia.com,
        ngottlieb@nvidia.com, Israel Rukshin <israelr@nvidia.com>
References: <20210111145754.56727-1-mgurtovoy@nvidia.com>
 <20210111145754.56727-2-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7dafb906-7bf4-63d4-1bab-4eeeb7210843@grimberg.me>
Date:   Wed, 13 Jan 2021 16:00:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111145754.56727-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
