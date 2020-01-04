Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BCA130016
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2020 03:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgADCPk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 21:15:40 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45015 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgADCPk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 21:15:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id w127so35238134qkb.11
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 18:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UEzqXzNb0zD7x8QIATlg32SdxdyUmh6HpKF2j9fIL3A=;
        b=UBHjR316MS48x7PB+JngMJsXtqZcmn5wDJB+prFNlA71Wcp4SLjB+nnC+pLEH0ErIs
         frb4UT9iP25SIDXL/u9mZ4+UUPLgYySl8oCiBl2GAKJg8d3k1sTJYUap35KMBsMneoGS
         2BTyAmtN+rGa9QdfJEpU+lTtY6ro4N8Y+yEb5SubkSamyAY0DW2Ywp60CJJrHYtFt86J
         FJd4u+bruZgIus6TvVumRfKTQ4+iC4JxI/p+yOajYduI87/dAwrPMXeF+YnL1QUvadQw
         NBHEPs3lrVcjFv2y5J1eeKqTkdwRT3xfuOATaVBlbu/P/bUoRcWIsv2f+D2GMOgdSSBS
         Dq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UEzqXzNb0zD7x8QIATlg32SdxdyUmh6HpKF2j9fIL3A=;
        b=PJPS6BjQXOX4XIXCNXE1m2jVOI8Ua6cMKdtCLRG5S4WyCcmS/tw6HekkUAZSk8/Ufl
         ICJG7wzlIXbHZGM6yTEzvE5yKbaXJcPr4dmvc0yEmLLDtdMadJyHR7NnL0Q752Jp8vqW
         MYp27yKiwekPMuqzi8nKu8ng7jblOSDG8NZgyhQeMWoHODosz9WMn/aD11Ty/gVA4JAu
         4/YQOkf/571H0NQw389XDsxnB+AwI7pvlrPGdyaAjPxPKk+SWvoEV07YXHt4dwJ1ayep
         mdxe071PhzI5UtpU0+OGRAMKv4/eyX2S81nwXAYBobtUoBlD8feUmuQasRv3cVR3Jjk+
         znAA==
X-Gm-Message-State: APjAAAX/kTbmXez5EXUejRP2RL1Jpp7XqMCKs6YimLlTvQmyDqSDEVfI
        NyKLGugAGootqw2dyLzac1cM7w==
X-Google-Smtp-Source: APXvYqwTF70WS2Y+8FHBTCkUSN65lWa4QXiinLhv/TW6P1yezpBx2lwBqgMK+LKDtynL/UeCc/w57w==
X-Received: by 2002:ae9:d887:: with SMTP id u129mr68572426qkf.357.1578104139248;
        Fri, 03 Jan 2020 18:15:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id z141sm17380436qkb.63.2020.01.03.18.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 18:15:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inYyX-0005oX-N9; Fri, 03 Jan 2020 22:15:37 -0400
Date:   Fri, 3 Jan 2020 22:15:37 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-rc v2 04/48] RDMA/cm: Add SET/GET implementations to
 hide IBA wire format
Message-ID: <20200104021537.GA15750@ziepe.ca>
References: <20191212093830.316934-1-leon@kernel.org>
 <20191212093830.316934-5-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212093830.316934-5-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 11:37:46AM +0200, Leon Romanovsky wrote:

> +#define IBA_FIELD64_LOC(field_struct, byte_offset, num_bits)                   \
> +	field_struct, (byte_offset)&0xFFF8,                                    \
> +		GENMASK_ULL(63 - (((byte_offset) % 8) * 8),                    \
> +			    63 - (((byte_offset) % 8) * 8) - (num_bits - 1)),  \
> +		64

This doesn't quite work out right, the 64 bit fields are not naturally
aligned and we never extract anything other than 64 bits from them. So
as written this one:

#define CM_SIDR_REP_SERVICEID CM_FIELD64_LOC(struct cm_sidr_rep_msg, 12, 64)

Gives a compilation failure.

Should be 

#define IBA_FIELD64_LOC(field_struct, byte_offset)                             \
	field_struct, (byte_offset)&0xFFF8, GENMASK_ULL(63, 0), 64

As we rely on the get_unaligned() to safely retrieve the 64 bits.

Jason
