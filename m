Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D571FD45D
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 20:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFQSXD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 14:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgFQSXC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 14:23:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE06C061755
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 11:23:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s88so1463552pjb.5
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yx0AFE8bnkOZ+0HVx0qf6qzKz6YFaE2RtkaHNSdil4Q=;
        b=Rl+zBYdfFS3UwL0fHb2iZoQ9Mc0+vQWPd3YXCCRD1mPlxoeRAcVPDQkxKV8SJrTMw1
         0uVOGChTPPkRXt2gXmGHyHS7MuBR5lINpp+c1q8L4VIrLfva85BsqCqe0Q/lQ6hbyqYw
         M7z8dS62N0oA81W8wwi5f7w6ypjp5Ha/apnbNJhYccBZOhTAqA5kI0oP6iXrQ7mxM750
         SGxtVl3LOsDfWu/N65yyLkiqgaRtHKfbRCBnpX3duQtiXd7vSgu08C/cyqK6onmC38Eg
         sLrjq65a14O+OqVEnlAbCOB1wrQV40nEhY+n3uw1YZ6HvsxfohLyT56332gWPtq2F8fT
         1r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yx0AFE8bnkOZ+0HVx0qf6qzKz6YFaE2RtkaHNSdil4Q=;
        b=oc6SmVcOicdvUvVDOoqUWq+nkNBvfHh9dEwZRrGOQuXeqeZ7TXCYjeTSwEMvqxvdez
         obEadMcCd3M0d+PeDl9II2wF3PIFTaUoWe7dhH7qTGb9WiXBGGsDyH4IPcSsUI5ux0h4
         eBfMvyiaCS2qkRnCRsxPagstQQViFS+Hts/MG/t1C5nttpM881WODbMe3Ogg0M033q5T
         f+9W82DAUzKLpg6ICSbwxnaK4J8/Ur7TLp5eA/CXAxogAxIqZ198Z1NuMWmXcMpJeaz/
         HUd9N4sOWhufcwUSDjz7r1GPA17fOD4h/5nkBhH/THG5HqYKeddzz58Vbwp/ZKDHlQvv
         MqTg==
X-Gm-Message-State: AOAM530Av9ZzNSI69wHAMH6UbNTHiInnoBCH8quhLvz17p/FKrjc3JjS
        S7SVffb0FWwjNWpUeBZTHFd88A==
X-Google-Smtp-Source: ABdhPJw15kXy8cl4re5NSa1ZgN8/0tpd5wuHfQ34K+X7a+RmU4ua2X9k8+4MCLa7CIrMdOVgxb3ZWg==
X-Received: by 2002:a17:90b:307:: with SMTP id ay7mr370815pjb.48.1592418181918;
        Wed, 17 Jun 2020 11:23:01 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id b1sm525823pfr.89.2020.06.17.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 11:23:01 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jlciC-009iIR-1W; Wed, 17 Jun 2020 15:23:00 -0300
Date:   Wed, 17 Jun 2020 15:23:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Divya Indi <divya.indi@oracle.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH v3] IB/sa: Resolving use-after-free in ib_nl_send_msg
Message-ID: <20200617182300.GJ6578@ziepe.ca>
References: <1591627576-920-1-git-send-email-divya.indi@oracle.com>
 <1591627576-920-2-git-send-email-divya.indi@oracle.com>
 <20200609070026.GJ164174@unreal>
 <ee7139ff-465e-6c43-1b55-eab502044e0f@oracle.com>
 <20200614064156.GB2132762@unreal>
 <09bbe749-7eb2-7caa-71a9-3ead4e51e5ed@oracle.com>
 <20200617051739.GH2383158@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617051739.GH2383158@unreal>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 08:17:39AM +0300, Leon Romanovsky wrote:
> 
> My thoughts that everything here hints me that state machine and
> locking are implemented wrongly. In ideal world, the expectation
> is that REQ message will have a state in it (PREPARED, SENT, ACK
> e.t.c.) and list manipulations are done accordingly with proper
> locks, while rdma_nl_multicast() is done outside of the locks.

It can't be done outside the lock without creating races - once
rdma_nl_multicast happens it is possible for the other leg of the
operation to begin processing. 

The list must be updated before this happens.

What is missing here is refcounting - the lifetime model of this data
is too implicit, but it is not worth adding I think

Jason
