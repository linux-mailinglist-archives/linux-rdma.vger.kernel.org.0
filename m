Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5939243B6A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfFMP25 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:28:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40134 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfFMP25 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 11:28:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so8309499pla.7;
        Thu, 13 Jun 2019 08:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yUJJ8iqcvuJ3BPVcgtI/PQYUXpHj8gT005mFggb92XQ=;
        b=PF3GNfhjtwVYJdzQBH96+/hxI1EhFG/gMHdHTnBfDvIBuBxpMxbseSn/0HkOCDhkDm
         JSk0oxYKaKsLKxUgd/3HTPaasTCgDkhU1AgxMIpGAqHtTI1x6GuFenwI1rtMu4wrFYp/
         e5tTP4UbcYIRq40/KTzyDLttdXHgGsgyzzFi7PohP5+DXHBAx4sAVAfO5aK9Vgtjlugq
         rw9WKZ81kBEe1eNDOUBlKPLA2Y4bdDZHVp//CTmMiyCYjDqBTJm2TMbYFnoJHLOGue/N
         kDa+luB3kqyZ1FLAQuPK3zKa9DHiO+tTFs7XSnJp0cN6/6fkNcXhQ0GUPRU1dfGn5ZZa
         MvOA==
X-Gm-Message-State: APjAAAWG9w8EuKdzM4hgqqU7IgAfyX2gevBs5KTJHv8nYm1GErXxf4dw
        oZFuLsiljcNikXenlRhCP+vAZu/B
X-Google-Smtp-Source: APXvYqw8UXQ2qB/hmtqwZrw/7powAQsjJBiHMBd48yk7lWGltCuWgtRv5qqnMMohLJcBcgyuOnD9Iw==
X-Received: by 2002:a17:902:bd94:: with SMTP id q20mr2154027pls.307.1560439735599;
        Thu, 13 Jun 2019 08:28:55 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r3sm164908pgp.51.2019.06.13.08.28.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 08:28:54 -0700 (PDT)
Subject: Re: [PATCH v2] RDMA/cma: Make CM response timeout and # CM retries
 configurable
To:     Doug Ledford <dledford@redhat.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190226075722.1692315-1-haakon.bugge@oracle.com>
 <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2c114313-01fe-6d4d-5134-592d1a7b829b@acm.org>
Date:   Thu, 13 Jun 2019 08:28:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/13/19 7:25 AM, Doug Ledford wrote:
> So, to revive this patch, what I'd like to see is some attempt to
> actually quantify a reasonable timeout for the default backlog depth,
> then the patch should actually change the default to that reasonable
> timeout, and then put in the ability to adjust the timeout with some
> sort of doc guidance on how to calculate a reasonable timeout based on
> configured backlog depth.

How about following the approach of the SRP initiator driver? It derives 
the CM timeout from the subnet manager timeout. The assumption behind 
this is that in large networks the subnet manager timeout has to be set 
higher than its default to make communication work. See also 
srp_get_subnet_timeout().

Bart.


