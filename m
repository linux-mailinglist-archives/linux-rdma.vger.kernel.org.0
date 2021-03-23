Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E38346DC1
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 00:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhCWXNe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 19:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbhCWXNY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Mar 2021 19:13:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF61C061574
        for <linux-rdma@vger.kernel.org>; Tue, 23 Mar 2021 16:13:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id l123so15930078pfl.8
        for <linux-rdma@vger.kernel.org>; Tue, 23 Mar 2021 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bsGu675No9dngICC5EINTZxy/TXuprPTCX9eZn7qRX8=;
        b=A9tWXssH6lXe+s+Mo/yW0uPEI15ANU7gWJVJZZVJd0rfcK8lWLO0WAXh4MFgkUiYtN
         89W8GOvX9rK0us8Fo4WEv8gPaIHIb5PfgkeBzIFR2q1XEda5KCXJ2KgdVh3nivg0SvNy
         Gm6pdJYys81RdDzgUBkYa9BTxInvkLDpYJswbLx0Hhjt6L9EO297Tna03HtKpZFqAHWJ
         URH4LRN/BlzLRn3RpP2HnHwZNT8KuTRmhK/Tg6WSGXW2niRNnkXoFaqQBX8K2tkULOhG
         W3K8j+ES/aNkGAgiil+jKX86/f2g+vqMSNIaGyEEtIuqs6Qz12wadRB1jyzZwmPRCLjG
         ZW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bsGu675No9dngICC5EINTZxy/TXuprPTCX9eZn7qRX8=;
        b=ZxgFfXmcRa557/atkTLA2q97TPGTO51Yu2BH9b4oEaUKDeDKSltlhtUOHWn0/nnMIF
         malY4BTBLdSSUicdh6XUbxDG7NOFaPLuJDzN7mE0WGffyPrORnAidC+JfjeAbyujp3Bq
         k9mteW9u0w8Y5gCvIC5YDHoPX24gv7+60rFS7NdwS30eEcyLHw0WIpfdC65HnWMwIJLu
         4G+v3grEVqrtzTR/9+cGilZM/56OfQf4g6P1drpmORUfkO/YZwSaaWETbH2PtZ15H9sa
         4J+YZOX+asF4j+K90UWYvrxcwAIjnkZuZ0Dy3K7cb9WBxKNbMOe5IW+gP3YftPNV1D3a
         sKbg==
X-Gm-Message-State: AOAM5305paNCW8/AOEOkZ7M0+A1m0q+mYuVRXp9M+JutvtnMfns8rVuD
        O1H6uu5AvX+ORL+IFxvgBZeR8w==
X-Google-Smtp-Source: ABdhPJwGJ3NjOc0//IwwbuFpZjJZMHw3huP0iHLxuzJL8uxTuwPMA+13T036eR4lXK2IQ3KtpAKQrg==
X-Received: by 2002:a63:6982:: with SMTP id e124mr538624pgc.46.1616541203850;
        Tue, 23 Mar 2021 16:13:23 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f21sm249668pfe.6.2021.03.23.16.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 16:13:23 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lOqDB-001jsH-FT; Tue, 23 Mar 2021 20:13:21 -0300
Date:   Tue, 23 Mar 2021 20:13:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc:     Praveen Kumar Kannoju <praveen.kannoju@oracle.com>,
        leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajesh Sivaramasubramaniom 
        <rajesh.sivaramasubramaniom@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Jeffery Yoder <jeffery.yoder@oracle.com>
Subject: Re: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for xlt
 update
Message-ID: <20210323231321.GF2710221@ziepe.ca>
References: <1615900141-14012-1-git-send-email-praveen.kannoju@oracle.com>
 <20210323160756.GE2710221@ziepe.ca>
 <80966C8E-341B-4F5D-9DCA-C7D82AB084D5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80966C8E-341B-4F5D-9DCA-C7D82AB084D5@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 23, 2021 at 12:41:51PM -0700, Aruna Ramakrishna wrote:
>    There is a far greater possibility of an order-8 allocation failing,
>    esp. with the addition of __GFP_NORETRY , and the code would have to
>    fall back to a lower order allocation more often than not (esp. on a
>    long running system). Unless the performance gains from using order-8
>    pages is significant (and it does not seem that way to me), we can just
>    skip this step and directly go to the lower order allocation.

Do not send HTML mails.

Do you have benchmarks that show the performance of the high order
pages is not relavent? I'm a bit surprised to hear that

This code really needs some attention to use a proper
scatter/gather. I understand the chip can do it, just some of the
software layers need to be stripped away so it can form the right SGL
in the HW.

Jason
