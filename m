Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E74121AC9
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2019 17:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfEQPkS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 May 2019 11:40:18 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:58870 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729130AbfEQPkS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 May 2019 11:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1558107617;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=V+NmDmRjkrblNlghj37E9UueKcnAUIY/dQz6QSu2kPg=;
        b=b6B43r6yi0R0NM/Wo1HRF6oJdrVY6Mj9Nzi0oU6vtos9/bCcdnfjKB2PYcuXqvPZ
        OqAi6Jcal5uZrViIa1E3k64TuGXCxmw+Cqyc50sHfvEqCLWa+7WawE0pnsLKk/fmk95
        8RlE6uKbVJKc9KODTnNKIPN0FdwYkKqP8qXNKB6Y=
Date:   Fri, 17 May 2019 15:40:17 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Steve Wise <larrystevenwise@gmail.com>
cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: rdma-core debian packages
In-Reply-To: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
Message-ID: <0100016ac67378f1-7e828df6-cebc-4c44-8e88-00503869d453-000000@email.amazonses.com>
References: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.05.17-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 17 May 2019, Steve Wise wrote:

> Is there a how-to somewhere on building the Debian rdma-core packages?

README.md?

