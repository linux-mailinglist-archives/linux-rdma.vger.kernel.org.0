Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525EE3AD080
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 18:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhFRQgL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 12:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbhFRQgL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 12:36:11 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788F5C061574
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 09:34:01 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g4so11116923qkl.1
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 09:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zsJwURKy/+VPPc7f40tfv9XS5yJZFqupae0wQuRhRHo=;
        b=MNMF0ARrZdnb3TRCBAdA0efHJW7ELp8S7ILGkmN1pU0YXlpAxcY9Q4DiSRvt01u/35
         KcDF899e5x/6tcAyyPhYPP/lpdoTVQYP8O0x3p4f61AwEee3HVN4WrZr7eS0J/qNWNvI
         VlnE/MAmJHTWPvBUf0r37eg3CA7n3t9GLt9fg/phSqjITb+4MeBs6B/vIbHuJgZnFDoH
         EJklXNCp0ILcUqyPEGqolgDIl8g/6HTi4tKapd4TQfbljc2RyUYvvReRAsQa1bTPxb6h
         FxwOWVyiZwu4+kTJsFCEfoSlBGTUukZSRsvQpeFGEeG30qmLE1pc0iqvgoROf1C8SPRG
         9O5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zsJwURKy/+VPPc7f40tfv9XS5yJZFqupae0wQuRhRHo=;
        b=gvVzkX225E2UFvd7xRxPiZrEHmYW0WqP+NSnTfISSAPoyl9bWusVwuRuO6ght5dPPF
         pDYrrVBY82FdJK8gNuKE1LNJuYioR9eCJKkkZ8L48WG6a5gXDk1loWQKW8mIJgqt/cRy
         WbkWZ1lPwwB24sPD4Zs4m1l1/ZOJy4bM+8s6PTjJdlMxfuM6Tjg0HhilD+aOYpWzMOdo
         /rdZEx4av3+IYXr4eBvxZz3b5NkgJObNREWKRJrAQlVyHQ5GTxDW7JZiz0oIJOCLAfOJ
         p/sJJkQoKp2ARmWQJGf4mRBu5wxGSOIJWqcSU1ZQ0uZtZnzUHIbze44pJlNJsQgHp2Cd
         RYLQ==
X-Gm-Message-State: AOAM530wZrOuj/WtDxtBhrmR+Djjj+QmRClgjEQ56e1U8X2shT/g7BuJ
        nCGQw0qkmSmCqAV4KLnazHlduQ==
X-Google-Smtp-Source: ABdhPJwfAmWtyXwTVQI0WyQKAYp0i0Tb1EkcVl7e2FYzRoSjTU16Y53ZlWpnW/va1LQfMfVqevAr8Q==
X-Received: by 2002:a37:a505:: with SMTP id o5mr10421263qke.355.1624034040632;
        Fri, 18 Jun 2021 09:34:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id t187sm4250483qkc.56.2021.06.18.09.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 09:34:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1luHRP-008afx-EW; Fri, 18 Jun 2021 13:33:59 -0300
Date:   Fri, 18 Jun 2021 13:33:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Shoaib Rao <rao.shoaib@oracle.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v1 3/3] RDMA/rxe: Increase value of RXE_MAX_AH
Message-ID: <20210618163359.GA1096940@ziepe.ca>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
 <20210617182511.1257629-3-Rao.Shoaib@oracle.com>
 <3aa5a673-3fd7-744b-b664-510005215bd2@gmail.com>
 <10d9763c-4d10-3820-93a0-b79f55acfa8e@oracle.com>
 <edcf0cc0-4da8-5af3-3366-220b4eeba5e4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edcf0cc0-4da8-5af3-3366-220b4eeba5e4@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 17, 2021 at 10:56:58PM -0500, Bob Pearson wrote:
 
> It isn't my call. But I am in favor of tunable parameters. -- Bob Pearson

Can we just delete the concept completely?

Jason
