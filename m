Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA335257F01
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 18:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHaQsQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 12:48:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45072 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgHaQsP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 12:48:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id 67so897120pgd.12
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 09:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JZoyJ+i1btAceigGLlHgc8ueeDHVUQX1G4sH8OoKrUA=;
        b=QXuE7qzlnjL0mvziQRPE0pDHK9Y2Wlf65UZ8awsbo9cS5A/c2A43PyaYFGR1QuQ4JB
         +FSxfTTbTEMwKUShvNpUQTGaaJRizGNd11Wi5PshCbHn0JngViDRq+074iWiXfwon/Gw
         ZfsZCG++kpN/RvaR7g6/bC4by3vcYEIkqgZnHrAwlhq90HIez0ZV67j2WYnhqUE5HGnm
         58NutT5snEy8a05MvDq9ITVTDT15O3jZIO6yiXHinlmMVOPo5JK7N8eaLmZbpY94HGlc
         O5dcf/LbgJrm70tyEdm7RlOSI3JqX/bnVF8cPLUWow9ovLnJw3PGfV3Rzd8qcguLrLiW
         aPww==
X-Gm-Message-State: AOAM530GOvB1/0Ws2tvrbMPtzj5yiLLgeVkiUDqaIhw4LrV9viaZcwOP
        RnL7titIvnoaUuXyaXja+FU=
X-Google-Smtp-Source: ABdhPJzXxlOR9290MY11paepk5cFMWwk+47PPgLOtrnlisbie5VVI0WLX4pjA+OS8G/kerNAAmyT1g==
X-Received: by 2002:a63:b202:: with SMTP id x2mr1839744pge.432.1598892495082;
        Mon, 31 Aug 2020 09:48:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:70b6:3990:a389:c0d1? ([2601:647:4802:9070:70b6:3990:a389:c0d1])
        by smtp.gmail.com with ESMTPSA id w3sm8779793pff.56.2020.08.31.09.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 09:48:14 -0700 (PDT)
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>, ming Lei <ming.lei@redhat.com>
References: <20200830103209.378141-1-sagi@grimberg.me>
 <20200831121818.GZ24045@ziepe.ca>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8bc2755b-e7d6-5d9c-f5e0-e8036b28beb6@grimberg.me>
Date:   Mon, 31 Aug 2020 09:48:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831121818.GZ24045@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Currently we allocate rx buffers in a single contiguous buffers
>> for headers (iser and iscsi) and data trailer. This means
>> that most likely the data starting offset is aligned to 76
>> bytes (size of both headers).
>>
>> This worked fine for years, but at some point this broke.
>> To fix this, we should avoid passing unaligned buffers for
>> I/O.
> 
> That is a bit vauge - what suddenly broke it?

Somewhere around the multipage bvec work that Ming did. The issue was
that brd assumed a 512 aligned page vector. IIRC the discussion settled
that the block layer expects a 512B aligned buffer(s).

Adding Ming to the thread.
