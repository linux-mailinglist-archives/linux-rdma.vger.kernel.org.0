Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C3D364AB
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 21:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFET2T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 15:28:19 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:38021 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFET2T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 15:28:19 -0400
Received: by mail-oi1-f176.google.com with SMTP id v186so4768217oie.5
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 12:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oViX5bNYIIQEE9dT+XK9zypO2Dl10vN3dIaeMo0avz0=;
        b=cxoYAzDdEOj5sWmN3hutmcqMFXSUvQR6EG2S3yzBPmHo+qeLsBJAJuHOxrmqCXsI82
         6wNEnJTo3GjjGlAJxKRxBs5+LmwYSaocYRYPELeedS8GL/FtbgVOXVkBG78oDtlBUz7r
         xW6s7WXoGp48tF6lX+rVFPmU6JYz2n9X0ioK1FLAX95im4Js3JF/I50QCDBJ2zcgxxxr
         r77tYfRnHk0wmKgNxXblhCan1an47k2O1N86+afPs5hk8QGreyb+fYfGpBMKuhu11jBg
         3wHz0jVSBQVca0uN9yiHPbxQqcbGN8X7BXwYha3IKfRnMI1XetzmQDO24dNPbrxOVLX7
         qVkg==
X-Gm-Message-State: APjAAAWg5lzcQIM1kFMrs3Osg5sgG9W2wupl+QN6tPqr3k49Vuzk5kiF
        WHQFQk40dGHh6XDf5pqeP2Y=
X-Google-Smtp-Source: APXvYqweD981UMKDbhAvSTPQ7E4uQE9x4CAsATcQHH9x4xxAe70isjaI6Y0Ih/rmEhlejI4Vuj/2DQ==
X-Received: by 2002:aca:c715:: with SMTP id x21mr10039463oif.142.1559762898230;
        Wed, 05 Jun 2019 12:28:18 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id p63sm7616590oih.1.2019.06.05.12.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:28:17 -0700 (PDT)
Subject: Re: [PATCH 07/20] RDMA/mlx5: Add attr for max number page list length
 for PI operation
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-8-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <257e556b-f248-0847-b7ed-23fb29d04a40@grimberg.me>
Date:   Wed, 5 Jun 2019 12:28:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-8-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> +	props->max_pi_fast_reg_page_list_len =
> +		props->max_fast_reg_page_list_len / 2;

is it page_list_len or sg_list_len? Also need to document that
both data and meta sges need to fit in this (and not respectively)
