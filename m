Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907B7D1E85
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 04:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfJJChk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 22:37:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41561 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfJJChk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 22:37:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so2883435pfh.8
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 19:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=jDj5V52U5xTiReCaQxdwl1Wy4Pgu3XL85Wr1xg/FK3o=;
        b=oS50rc6iHGi/Vwb3FeZHHicVb/Rnb1tGHLAO3ThEFqLc6xm/Ya8Xk9MJkkKaNXAo/d
         XcAbXLI4lTYVu1k5aSkI3bOyn/pE8gT9WRrIbb0E/oZW1J5ljZCa/hBZUIp+vcxpfjXc
         ovnKLZP4Dh7WRqfKRPzWiB5Yq6a/XCrYV60AW4Si1DEdv+CBNaYlNsuR6yOfXNaU59Pq
         haceGEbLu4afSSKQua8Q8AIYW1+Wx1BIwJA0VhIR0FEHsHHMlM67ye9Ir73kjHopjCJ+
         74w/ZuY+9rcWjZv1Qz3b9LJHILZUw+RCJlMOciqrcEtr632uPqTw8uA7JIYeLfYlIsrG
         Wj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=jDj5V52U5xTiReCaQxdwl1Wy4Pgu3XL85Wr1xg/FK3o=;
        b=P0vY7zs+nzU9lglPo1HYDlbS7MdfEvOmw13pgJryVCdzU7dZ+6Uo0vF2bo68A1r1AE
         mrJgHipOUB9AKOqqAySQH/eZKHGoUhww87wNqDL6iGu7heyPd8fscDHRtycRr9BTR0qk
         rGF4xHC1TfjtBtWmhmPRQW+946Ydbkti8iu2ONrpU205OnjweB0qAg5fhQepI7vVtd/I
         UCybF7lt/xybfCSuwFBSmzUwQAvf6OWHA19SFtBmSoqsXXEY9vxqRNphpLFyEbR36Y6b
         azuv4+DeOMXjj+TgzUZ9qCKA7GEdirwC9KyRKrwNzyP7mCzH2iuOz7H09YCR+wjrkddb
         X8pQ==
X-Gm-Message-State: APjAAAWfO8EpGcvw7IyyHjcYcHTZb4taOewfl+fqr85wBvgkRzPzEV6+
        T+Nv6HzOOHnwW0ktnLK/hQp2fw==
X-Google-Smtp-Source: APXvYqyveXVAz9bIuwZtUAHK52ARF4ljhWlYEKMPMJprXOxzfsJrBKzLyspm+V+JLqlKkdhkIJnEYg==
X-Received: by 2002:a63:f810:: with SMTP id n16mr7909486pgh.176.1570675059958;
        Wed, 09 Oct 2019 19:37:39 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id h26sm3266773pgh.7.2019.10.09.19.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 19:37:39 -0700 (PDT)
Date:   Wed, 9 Oct 2019 19:37:26 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Yamin Friedman <yaminf@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] DIM: fix dim.h kernel-doc and headers
Message-ID: <20191009193726.098eb771@cakuba.netronome.com>
In-Reply-To: <6f8dd95f-dc58-88b9-1d20-1a620b964d86@infradead.org>
References: <6f8dd95f-dc58-88b9-1d20-1a620b964d86@infradead.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 8 Oct 2019 21:03:14 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Lots of fixes to kernel-doc in structs, enums, and functions.
> Also add header files that are being used but not yet #included.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yamin Friedman <yaminf@mellanox.com>
> Cc: Tal Gilboa <talgi@mellanox.com>
> Cc: Saeed Mahameed <saeedm@mellanox.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: netdev@vger.kernel.org

I capitalized some of the descriptions looks like this file prefers that.

Otherwise seems reasonable, applied to net-next, thank you!
