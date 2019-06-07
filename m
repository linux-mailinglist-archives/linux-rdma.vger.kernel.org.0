Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DA53892E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 13:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfFGLh7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 07:37:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37133 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbfFGLh7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 07:37:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so1442403ljf.4
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fRds4+BVAv/doBLU8hXnnNZ1HhXNCYgPq9/hyaBuW3c=;
        b=VAIH6Cy3IJTyIkF83L8zSWEKjVVk6CK49bnH+GtoEXsWIB9z831zxjNeAZD9ThvxcP
         DqwYZpujX1Bqo1EvQDMzl1vIjcGPTz+Yk154RrQGEHxeAsN94bpNoxSkUeGTjUA6ZSfK
         nLHHtEVNzmsdgJUEfs0/sO+i64nOwtB8ZNVmVn2hbwtNf1CyFoSSZ5s/TsyzYy55H4pM
         c3gegD5SIHxDIqzWjr+/T0qBTE9uWUzhshlJX/aBD9lAMsAZc2xY20hZzQsCgzSte+V+
         1c7V/8yFluekIUBwSgH/ejhBlzRashoehBA3z0c84+v0SjMDeuZFu9rRhlNw9ZXO/tz4
         O/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fRds4+BVAv/doBLU8hXnnNZ1HhXNCYgPq9/hyaBuW3c=;
        b=sSWxgyhrit4xiF9GFUrXvZPyj5O3wuNTbgXW/R5VZ63IzO04qMBoWoIzcZJn8Y2wrF
         hsYV+9vxHH6IW/iqvPZ4wYcgfF+xHnU4izMNs+CddfWypN91xD5UMmlSYk+uQwSUeccm
         ZFsMMsaMOKYLK/aG0nEoSovNcDClBNlby20YrOQxDuaJfBpFy0+Sr884D/SVk3tAW/P2
         4zTas1wQmGvfb0g5MdJx8C3geAN3qHKNLWXXroRS9iM4SgNiFZ2i79WLLdE+PXetXNda
         gQtj2KxGAm576RHdFFMiLI4LDpFmr5WwbgWOCmqOYJKJFKXAW1Qlw73eLpXL5ALJdr1H
         8DCg==
X-Gm-Message-State: APjAAAWs855YIO01+YpCnpHrVnWRXwF/VCGx/Gh6w64+nS0Jjw6JHkvx
        RLeQkOuJ8EHm6MPQz3mgB972sg==
X-Google-Smtp-Source: APXvYqzjPp0FChqLKiUc7SZMya2ciwcmsp6uDZ30YcA8bLLgXx79donMwCBINLwrj+/6lz4LMjtoZQ==
X-Received: by 2002:a2e:9e14:: with SMTP id e20mr27260572ljk.172.1559907477284;
        Fri, 07 Jun 2019 04:37:57 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.83.123])
        by smtp.gmail.com with ESMTPSA id a18sm341299ljf.35.2019.06.07.04.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 04:37:56 -0700 (PDT)
Subject: Re: [PATCH trivial] net/mlx5e: Spelling s/configuraion/configuration/
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Kosina <trivial@kernel.org>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190607111026.12995-1-geert+renesas@glider.be>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <1e408f5d-04f8-99f3-0452-9638ea0b9d69@cogentembedded.com>
Date:   Fri, 7 Jun 2019 14:37:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190607111026.12995-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello!

On 06/07/2019 02:10 PM, Geert Uytterhoeven wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

  Unfortunately, while fixing this typo, you made another one, in your subject. ;-)

[...]

MBR, Sergei
