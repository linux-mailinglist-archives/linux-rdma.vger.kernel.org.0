Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72DF4D3D4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfFTQdd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 20 Jun 2019 12:33:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35064 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTQdd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 12:33:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so1979702pfd.2
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2019 09:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U0FaXt7/eeokQqk9S3QJAONyoUCIauqbS/182BzfGDo=;
        b=P9dhLDbMpQEIybqkxDyVwLMjgKlGQO3VSMhJccxoCEANPcqqSHOXlhSUT62FO5wBqp
         /GzD+ej35BXD4xyiDKw5Tmc6NpjZp4mFxPD2VoufNRO7IjaFUvysZ8KR5MIgp2o4VAbU
         b929xHgpfRLddo2sUL29YWS+4Pz27cPqLBcxWoSHnHJdPqXa2yz0EE8FZaCpUhW3CSaQ
         QHeuQY+Us2izSqm5tzFSXYABZ+hNZ8svoOZM+Yq1jOL4oJ05lNwt/Aep8MLFjwTFSmvu
         /BfbX1js+f2MacUe0Pc45J1wrQSHs1U3sWXsslJv1IS0eu4R+rx+vrBRIW0e1DLr8Fec
         bxqQ==
X-Gm-Message-State: APjAAAWEYane/CkDI6bCeDpmw2KOkcPi34oMowLAondLhQ2SjTdZkbHG
        Eu/hTGkBtwR8g6aAckZYnwpYICdgQT0=
X-Google-Smtp-Source: APXvYqwngZLmAjLp1JXctxqNH7tEf5Fuij/0wScWBEdeutk6kSSpHT5aG5jduefBg9OT93iYRHHAmQ==
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr474883pje.123.1561048411913;
        Thu, 20 Jun 2019 09:33:31 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id j64sm34071751pfb.126.2019.06.20.09.33.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 09:33:30 -0700 (PDT)
Subject: Re: [PATCH v3 05/11] SIW application interface
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
References: <20190620162133.13074-1-bmt@zurich.ibm.com>
 <20190620162133.13074-6-bmt@zurich.ibm.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f805a19d-256f-fa60-fc2d-dbc0939ed5cf@acm.org>
Date:   Thu, 20 Jun 2019 09:33:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620162133.13074-6-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 9:21 AM, Bernard Metzler wrote:
> diff --git a/include/uapi/rdma/siw-abi.h b/include/uapi/rdma/siw-abi.h
> new file mode 100644
> index 000000000000..3dd8071ace7b
> --- /dev/null
> +++ b/include/uapi/rdma/siw-abi.h
> @@ -0,0 +1,185 @@
> +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
> +
> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
> +/* Copyright (c) 2008-2019, IBM Corporation */
> +
> +#ifndef _SIW_USER_H
> +#define _SIW_USER_H
> +
> +#include <linux/types.h>
> +
> +#define SIW_NODE_DESC_COMMON "Software iWARP stack"

How can the definition of a string like this be useful in an UAPI header
file? If user space code doesn't need this string please move this
definition away from include/uapi.

> +#define SIW_ABI_VERSION 1

Same question here: how can this definition be useful in an UAPI header
file? As you know Linux user space APIs must be backwards compatible.

Thanks,

Bart.

