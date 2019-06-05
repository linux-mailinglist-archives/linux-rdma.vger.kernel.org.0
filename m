Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1613A364DB
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 21:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFETjb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 15:39:31 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36380 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFETjb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 15:39:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id w7so7706084oic.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 12:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/CvmmvvM/R4J7PMbZYH0r+SgrdsxgVsX7dB6O9v6DaE=;
        b=HQR526mKkXIBzXTJqwj50NZ4rahYPv8QGdY2ycmqVi5f2T+00YT68fyHTPqTxhTdfH
         adm0c8dOUvEnDFUNessHFpLLqEPH2j6P0wq9Tzca3+fTypx3UlMeAaJQc8iQcifpBL34
         Ei6YwLmVq5bIz2Z6sjARGdi+8FcCbO0zq03kPw7bbTWE3vJP3jwSXDtBvyz69m6cIHLy
         vjgdH71i/zaoafETsODCUERLawqrtRwM6M1xqQoZ/FnzVs3MwgifJkBlrMxhl91fWlAJ
         vvrArQlLazk291s+oOTjwemY5iApObPD+GEmLaqTPGm0ijUbjc4DpLP7PzipCydIYVrM
         zVRg==
X-Gm-Message-State: APjAAAVIQa2yhkRPMpJ2EOltuC70rDn7IUp20D8+mAx2K0mo2KR4TBW4
        QArFWGafTThz8mDNg9goeao=
X-Google-Smtp-Source: APXvYqyDKGtrWn6C5qLSQDtO0SAbHb8P+a2zba2ExSW/yYxKHX4/kv/kKb03ciE0OFknUsjK0qbQxQ==
X-Received: by 2002:aca:db09:: with SMTP id s9mr9318274oig.118.1559763570875;
        Wed, 05 Jun 2019 12:39:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id e4sm7572222oti.64.2019.06.05.12.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:39:30 -0700 (PDT)
Subject: Re: [PATCH 15/20] RDMA/core: Validate signature handover device cap
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-16-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4780f87f-98ba-9432-2de9-352bdf8bf5a0@grimberg.me>
Date:   Wed, 5 Jun 2019 12:39:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-16-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> -	if (qp_init_attr->rwq_ind_tbl &&
> -	    (qp_init_attr->recv_cq ||
> -	    qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
> -	    qp_init_attr->cap.max_recv_sge))
> +	if ((qp_init_attr->rwq_ind_tbl &&
> +	     (qp_init_attr->recv_cq ||
> +	      qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
> +	      qp_init_attr->cap.max_recv_sge)) ||
> +	    ((qp_init_attr->create_flags & IB_QP_CREATE_SIGNATURE_EN) &&
> +	     !(device->attrs.device_cap_flags & IB_DEVICE_SIGNATURE_HANDOVER)))

Wouldn't it make sense to also change the qp create flag and the device
cap to be PI_EN/PI_HANDOVER while we're at it?
