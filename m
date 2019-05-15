Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75281E658
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 02:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfEOAgF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 20:36:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43966 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfEOAgF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 20:36:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id z6so438132qkl.10
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 17:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iq3kisXGM8JbsiEEgETVGj1T02YzCqLyozJaDHSc6rw=;
        b=R65M6nXnarK3hPma+DW0PwoNIHwM0NN/a10dAwPx9IOSQOO36zktV7LJnNHC0xCJbV
         CTVjJAhRrPmqAaLEapD9i5oCdmyzJaTNq6qlHyOpSe4Ly9TNpq40ixdtOjW66PwpPb9Q
         8gCR0hAYWeXF4+6USkoRB6d6iWAKAK5EazR6wditNrwWU0N/2ckh7Y2ADf/5/Af5Y0bi
         Bp8V38YQHJSDz3Ah6pjmAxg/JTJAniqQs3LVG6nnPt5adKD4WjxQKYK547CUNSQ/Bddv
         1Gk87Xqd4bHbuwtWO7s+GU2UCE8HslYptF1HvQkaCu+6+AEr3PuAhnhGb/rCRmWsUoTL
         YUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iq3kisXGM8JbsiEEgETVGj1T02YzCqLyozJaDHSc6rw=;
        b=WVU00gghAiJHULUlFFaWCMzgSMCaGnRFBQB+AQ64F/bfzb4CvOsZxo+THiE88p0RK2
         rXkyinUiQONUI1Macm1J8TJEjkYE67K+FSAKWDri9QNoqZiqcWi7SopRspN5ZTRTyEH5
         5tYu2S95D3btAFExCldP/E1ZteBRJc2ZAMSgPSUOXwQgJcXyGQMytxQlTUMiXXq/l7oG
         95Iq7aHdhb4Tju+oJehCgvGq32KNUbLVHsihGJIHp3kRU6WIc4U61d7EIGyOj7PvFhvD
         w6nLSfhLh08kr3ea88K8TcDUFtjFyIosZ53VvTRUiY0GChKWjjCptn7QWel2ydr1GhF/
         dE5A==
X-Gm-Message-State: APjAAAVXN0oQl/pqijy4OpqvSrbfFMxULv3aAEPCwahUvLjKdHS42rFR
        84WzWx8B6L+XWAnhGJaKRI/SjvKOl5M=
X-Google-Smtp-Source: APXvYqyFVaCX7p/45fwcKGzjRDu2DRD4Qk3+gZeT0+eCPlGSzXcq82NL1RA/he0bu3n3FtHcov0LsA==
X-Received: by 2002:a05:620a:13b8:: with SMTP id m24mr9428323qki.268.1557880564604;
        Tue, 14 May 2019 17:36:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id v3sm513712qtc.97.2019.05.14.17.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:36:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhtr-0001tc-RI; Tue, 14 May 2019 21:36:03 -0300
Date:   Tue, 14 May 2019 21:36:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 0/2] DevX fixes
Message-ID: <20190515003603.GB7248@ziepe.ca>
References: <20190514114412.30604-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514114412.30604-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 02:44:10PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> There are two very short but important fixes to DevX flows.

applied to for-next

Jason
