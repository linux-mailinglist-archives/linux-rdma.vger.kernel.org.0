Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5114394889
	for <lists+linux-rdma@lfdr.de>; Sat, 29 May 2021 00:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhE1WJN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 18:09:13 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:45675 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1WJN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 18:09:13 -0400
Received: by mail-pg1-f179.google.com with SMTP id q15so3528378pgg.12;
        Fri, 28 May 2021 15:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7/tJAO3VxrD008ZBPl+fKUiQuR+tQKb8eTYm3REGkHQ=;
        b=hbcwTsG3KqgU2lRA3D0obVeTJnEbVbNqwGHpYzQOVv8IWN9I/vDaO4dAu4J4/PNpFv
         tVxJXuW0NL5FG2aWp/9CgBiIBpudYStuiBKCxXum4xdDwjHcyakTmNTjaSx2HpOS/WzJ
         wELz/uG8DNeK3IPVcVV2bd69QwIBHkiep+Kt5D0Ue0mJP77jz+wiVn2Bgxa4CgtaakrE
         MUnubYy3msVEWHkEb4Bqw8LzZS3CrURFHUhSHQvJYr/OPsPGXL1zwp93h6FoA5vmUcLI
         CJUaEOWUPTHbo/wz7TAaCMtY6RqOttKSRAsDWp6duz63/s6yDuPbkKCDw0UOnxHqPnJv
         rQEQ==
X-Gm-Message-State: AOAM5310NVxmoYhzZiTmqKgTnnVUd/J/CKMTntepAJ29gOTXZVy4Kwqe
        irj1Faq6MijKdABOcJ7HXryq5mbhtpI=
X-Google-Smtp-Source: ABdhPJz2EXaibKy4cVHl9jbxgn+20L/OQAK8JvByBKDAJNNZ+GYaLfMxQgr/fuQR0U1D8BDDxa1Rsw==
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id p30-20020a056a000a1eb02902e289d85c87mr5947810pfh.73.1622239656666;
        Fri, 28 May 2021 15:07:36 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id y190sm5204794pgd.24.2021.05.28.15.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 15:07:36 -0700 (PDT)
Subject: Re: [PATCH v3 -next] RDMA/srp: use DEVICE_ATTR_*() macro
To:     YueHaibing <yuehaibing@huawei.com>, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210528125750.20788-1-yuehaibing@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <96b606c0-ba7b-ec6a-a95f-5c579b6d02e8@acm.org>
Date:   Fri, 28 May 2021 15:07:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528125750.20788-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/28/21 5:57 AM, YueHaibing wrote:
> -static ssize_t show_id_ext(struct device *dev, struct device_attribute *attr,
> -			   char *buf)
> +static ssize_t id_ext_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)

Please make better use of horizontal space by moving "struct
device_attribute *attr," to the end of the previous line. This advice
probably also applies to other changes in this patch.

Thanks,

Bart.
