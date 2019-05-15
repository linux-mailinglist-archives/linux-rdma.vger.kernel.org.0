Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 886A91F95F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 19:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEORck convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 15 May 2019 13:32:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36181 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEORck (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 13:32:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so971050edx.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 May 2019 10:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GT8wmmQdIHTnGUAcmNvTL9fntJCMAgk1z0hY2szmhm0=;
        b=gOBg1UoPCxjEJOE6PCzHxQR3QjNxFBHK93/Pg+ZYfqZeDSNlcRmQ5ZLFFEXrfyIffl
         ppX3wgpDcn9kEU/jRWWLcgu3TnK5vlA0FD17J+MUvCYEqxTgraZWwRN8C3BdL9RuEiUc
         35U1Zg5ZOVJKIpPOUNd4BaI8LRsAl5K40+OcPXFptbDQQjEo26gzRDTMaUp77SjnE1+y
         oDbletS6uop8zLWqthblmOtag+d+zwiyBRLbvvB9acxTig5Js1miamj+qgfsB7hTIkPt
         BePUiTINPJrpLxpebm7/pZA+901LdjdJBH6Km+Sh+Qw7i9uAVKBm8tidI75A5MCkobtC
         y1Mg==
X-Gm-Message-State: APjAAAVbktROCK+hjHLNUpK0Li2pHlg21wnHyIvWA+74WyB7Ub7jOCxT
        U/wsfpkyOJjkT2b8lcFdUjX3MXsc
X-Google-Smtp-Source: APXvYqy/FNFAoiU+rH9zrl59QXGLeibCxy1u0kxLDLMqqQjtBAGRKxbIJpMQvRns5XV3K+xsknefTQ==
X-Received: by 2002:a50:ee01:: with SMTP id g1mr44516047eds.263.1557941558145;
        Wed, 15 May 2019 10:32:38 -0700 (PDT)
Received: from [192.168.1.6] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id j55sm1057595ede.27.2019.05.15.10.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 10:32:36 -0700 (PDT)
Subject: Re: [RFC PATCH rdma-next v2] RDMA/srp: Rename SRP sysfs name after IB
 device rename trigger
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190515170638.11913-1-leon@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <97b980a9-6a2a-234e-c12c-b7ee5fd4262e@acm.org>
Date:   Wed, 15 May 2019 19:32:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515170638.11913-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/15/19 7:06 PM, Leon Romanovsky wrote:
> +	list_for_each_entry_safe(host, tmp_host, &srp_dev->dev_list, list) {
> +		char name[IB_DEVICE_NAME_MAX * 2] = {};
                          ^^^^^^^^^^^^^^^^^^^^^^
I think this should be IB_DEVICE_NAME_MAX + 8 instead of ... * 2. Please
also consider to leave out the initialization of the char array since
snprintf() overwrites the array whether or not it has been initialized.

> +		snprintf(name, IB_DEVICE_NAME_MAX * 2, "srp-%s-%d",
                               ^^^^^^^^^^^^^^^^^^^^^^
Please change this into sizeof(name) such that the size expression only
occurs once.

Thanks,

Bart.

